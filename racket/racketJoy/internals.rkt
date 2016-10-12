#lang racket

(require racket/pretty)

(module+ privateAPI ; used by specifications
  (provide
    evalStack
  )
)

(provide 
  defineJoy
  extendJoy
  extendJoy1
  extendJoy2
  extendJoy3
  evalCmdListOnStack
  addArgsToJoyStack
)

(define traceJoy #f)
(define showStack #f)
(define evalCmdListDepth 0)

(define joyStack '())    ;; an empty immutable list/stack
(define joyTable (hash)) ;; an empty immutable hash table

(define (reportJoyCallArgs argListNames argList)
  (unless (or (null? argListNames) (null? argList))
    (displayln (format "~a = ~a" (car argListNames) (car argList)))
    (reportJoyCallArgs (cdr argListNames) (cdr argList))
  )
)

(define (reportJoyCall definedName argListNames argList)
  (when traceJoy
    (when (not showStack) (newline))
    (displayln (format "calling: [~a]" definedName))
    (reportJoyCallArgs argListNames argList)
  )
)

(define (makeSymbol aSymbolOrString)
  (cond
    [ (string? aSymbolOrString) (string->symbol aSymbolOrString) 
    ] [ (symbol? aSymbolOrString) aSymbolOrString
    ] [ else 
      (begin
        (displayln 
          (format "[~a] can not be made into a symbol! (using 'unknown)"
            aSymbolOrString
          ) 
        )
        'unknown
      )
    ]
  )
)

(define (addDefToJoyTable definedSymbol aDefinition)
  (set!
    joyTable
    (hash-set
      joyTable
      (makeSymbol definedSymbol)
      aDefinition
    )
  )
)

(define-syntax (defineJoy someSyntax)
  (syntax-case someSyntax ()
    [ (_ definedName definedBody)
      #'(addDefToJoyTable
        (makeSymbol definedName)
        (quote definedBody)
      )
    ]
  )
)

(define-syntax (extendJoy someSyntax)
  (syntax-case someSyntax ()
    [ (_ ( definedName theStackArg ) definedBody ... )
      #'(addDefToJoyTable
        (makeSymbol definedName)
        (lambda (theStackArg)
          (reportJoyCall definedName '(theStackArg) (list theStackArg))
          definedBody ...
        )
      )
    ]
  )
)

(define-syntax (extendJoy1 someSyntax)
  (syntax-case someSyntax ()
    [ (_ ( definedName someArgs ... ) definedBody ... )
      #'(addDefToJoyTable
        (makeSymbol definedName)
        (lambda (aStack)
          (let ([ extendJoy1top1 (car aStack) ]
                [ extendJoy1rest (cdr aStack) ])
            (apply 
              (lambda (someArgs ... )
                (reportJoyCall definedName '(someArgs ...) (list someArgs ...))
                definedBody ...
              )
              extendJoy1top1 (list extendJoy1rest )
            )
          )
        )
      )
    ]
  )
)

(define-syntax (extendJoy2 someSyntax)
  (syntax-case someSyntax ()
    [ (_ ( definedName someArgs ... ) definedBody ... )
      #'(addDefToJoyTable
        (makeSymbol definedName)
        (lambda (aStack)
          (let ([ extendJoy2top1 (car  aStack) ]
                [ extendJoy2top2 (cadr aStack) ]
                [ extendJoy2rest (cddr aStack) ])
            (apply 
              (lambda (someArgs ... )
                (reportJoyCall definedName '(someArgs ...) (list someArgs ...))
                definedBody ...
              )
              extendJoy2top1 extendJoy2top2 (list extendJoy2rest )
            )
          )
        )
      )
    ]
  )
)

(define-syntax (extendJoy3 someSyntax)
  (syntax-case someSyntax ()
    [ (_ ( definedName someArgs ... ) definedBody ... )
      #'(addDefToJoyTable
        (makeSymbol definedName)
        (lambda (aStack)
          (let ([ extendJoy3top1 (car   aStack) ]
                [ extendJoy3top2 (cadr  aStack) ]
                [ extendJoy3top3 (caddr aStack) ]
                [ extendJoy3rest (cdddr aStack) ])
            (apply 
              (lambda (someArgs ... )
                (reportJoyCall definedName '(someArgs ...) (list someArgs ...))
                definedBody ...
              )
              extendJoy3top1 extendJoy3top2 extendJoy3top3
                (list extendJoy3rest )
            )
          )
        )
      )
    ]
  )
)

(define (evalCmdListOnStackRecurse aCmdList aStack)
  (when traceJoy
    (newline)
    (displayln (format "remaining[~a]: ~a" evalCmdListDepth aCmdList))
  )
  (if (and (list? aCmdList) (not (null? aCmdList)))
    (evalCmdListOnStackRecurse 
      (cdr aCmdList)
      (evalStack (cons (car aCmdList) aStack))
    )
    aStack
  )
)

(define (evalCmdListOnStack aCmdList aStack)
  (set! evalCmdListDepth (+ evalCmdListDepth 1))
  (let ([ result (evalCmdListOnStackRecurse aCmdList aStack)])
    (set! evalCmdListDepth (- evalCmdListDepth 1))
    result
  )
) 

(define (evalSymbol command aStack)
  (let ([ cmdImpl (hash-ref joyTable command 'unknown) ])
    (cond
      [ (procedure? cmdImpl) (apply cmdImpl (list aStack))
      ] [ (list? cmdImpl)
        (begin
          (when traceJoy
            (newline)
            (displayln (format "evaluating: [~a]" command))
            (displayln (format "body = ~a" cmdImpl))
          )
          (evalCmdListOnStack cmdImpl aStack)
        )
      ] [ else (cons command aStack)
      ]
    )
  )
)

(define (reportAndReturnStackUpdate aStack)
  (when traceJoy
    (newline)
    (displayln (format "adding: ~a" (car aStack)))
  )
  aStack
)

(define (evalStack aStack) 
  (let ( [ command (car aStack) ]
         [ rest    (cdr aStack) ] )
    (cond
      [   (list?   command) (reportAndReturnStackUpdate aStack)
      ] [ (number? command) (reportAndReturnStackUpdate aStack)
      ] [ (string? command) (reportAndReturnStackUpdate aStack)
      ] [ (symbol? command) (evalSymbol command rest)
      ] [ else 
        (begin
          (displayln (format "unknown command [~a] ignored" command))
          (evalStack rest)
        )
      ]
    )
  )
)

(define (showStackCall aStack)
  (when traceJoy (newline))
  (pretty-display aStack)
  (newline)
)

(define (addArgsToJoyStack someArgs)
  (set! joyStack (evalStack (cons someArgs joyStack) ) )
  (when showStack (showStackCall joyStack))
)

;; Useful extensions to the Joy langauge
;;
(extendJoy1 ('load top1 rest)
  (dynamic-require top1 #f)
  rest
)

(extendJoy2 ('define top1 top2 rest)
  (defineJoy top1 top2)
  rest
)

(addDefToJoyTable 'definitions
  (lambda (aStack)
    (hash-map
      joyTable
      (lambda (aKey aValue)
        (displayln (format "~a == ~a" aKey aValue))
      )
      #t
    )
    aStack
  )
)

(addDefToJoyTable 'traceOn
  (lambda (aStack)
    (set! traceJoy #t)
    aStack
  )
)

(addDefToJoyTable 'traceOff
  (lambda (aStack)
    (set! traceJoy #f)
    aStack
  )
)

(addDefToJoyTable 'showStackOn
  (lambda (aStack)
    (set! showStack #t)
    aStack
  )
)

(addDefToJoyTable 'showStackOff
  (lambda (aStack)
    (set! showStack #f)
    aStack
  )
)

(addDefToJoyTable 'showStack
  (lambda (aStack)
    (showStackCall aStack)
    aStack
  )
)

(extendJoy1 ('comment top1 rest)
  rest
)

(extendJoy1 ('-- top1 rest)
  rest
)

;; XREPL/Readline completion helper
;;
(require readline/rktrl)
(set-completion-function!
  (lambda (aPrefix)
    (sort
      (filter
        (lambda (anItem)
          (string-prefix? anItem aPrefix)
        )
        (map symbol->string (hash-keys joyTable))
      )
      string<?
    )
  )
)
