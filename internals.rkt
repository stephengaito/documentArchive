#lang racket

(require racket/pretty)

(provide 
  defineJoy
  extendJoy
  extendJoy1
  extendJoy2
  extendJoy3
  evalStack
  evalCmdListOnStack
  addDefToJoyTable
  addArgsToJoyStack
  showJoyStack
)

(define traceJoy #f)
(define joyStack '())    ;; an empty immutable list/stack
(define joyTable (hash)) ;; an empty immutable hash table

(define (showJoyStack)
  (displayln joyStack)
)

(define (makeSymbol aSymbolOrString)
  (cond
    [ (string? aSymbolOrString) (string->symbol aSymbolOrString) 
    ] [ (symbol? aSymbolOrString) aSymbolOrString
    ] [ else 
      (begin
        (displayln 
          (string-append "[" (~a aSymbolOrString) 
            "] can not be made into a symbol! (using 'unknown)")
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
        (lambda (theStackArg) definedBody ... )
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
              (lambda (someArgs ... ) definedBody ... )
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
              (lambda (someArgs ... ) definedBody ... )
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
              (lambda (someArgs ... ) definedBody ... )
              extendJoy3top1 extendJoy3top2 extendJoy3top3
                (list extendJoy3rest )
            )
          )
        )
      )
    ]
  )
)

(define (evalCmdListOnStack aCmdList aStack)
  ;(displayln aCmdList)
  ;(displayln aStack)
  (if (and (list? aCmdList) (not (null? aCmdList)))
    (evalCmdListOnStack 
      (cdr aCmdList)
      (evalStack (cons (car aCmdList) aStack))
    )
    aStack
  )
) 

(define (evalSymbol command aStack)
  (let ([ cmdImpl (hash-ref joyTable command 'unknown) ])
    (cond
      [ (procedure? cmdImpl) (apply cmdImpl (list aStack))
      ] [ (list? cmdImpl)    (evalCmdListOnStack cmdImpl aStack)
      ] [ else (cons command aStack)
      ]
    )
  )
)

(define (evalStack aStack) 
  ;(displayln (string-append "evalStack: " (~a aStack)))
  (let ( [ command (car aStack) ]
         [ rest    (cdr aStack) ] )
    (when traceJoy
      (begin
        (displayln "command: ") 
        (pretty-display command)
        (displayln "  stack: ")
        (pretty-display rest)
        (newline)
      )
    )
    (cond
      [   (list?   command) aStack
      ] [ (number? command) aStack
      ] [ (string? command) aStack
      ] [ (symbol? command) (evalSymbol command rest)
      ] [ else 
        (begin
          (displayln 
            (string-append 
              "unknown command [" (~a command) "] ignored"
            )
          )
          (evalStack rest)
        )
      ]
    )
  )
)

(define (addArgsToJoyStack someArgs)
  (set! joyStack (evalStack (cons someArgs joyStack) ) )
  (pretty-display joyStack)
  (newline)
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
        (displayln (string-append (~a aKey) " == " (~a aValue)))
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
