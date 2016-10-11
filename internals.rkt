#lang racket

(provide 
  extendJoy
  evalStack
  evalCmdListOnStack
  addArgsToJoyStack
  showJoyStack
)

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

(define (extendJoy definedSymbol aDefinition)
  (set!
    joyTable
    (hash-set
      joyTable
      (makeSymbol definedSymbol)
      aDefinition
    )
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
  (displayln joyStack)
)

;; Useful extensions to the Joy langauge
;;
(extendJoy 'load
  (lambda (aStack)
    (let ([ top0 (car aStack) ]
          [ rest (cdr aStack) ])
      (dynamic-require top0 #f)
      rest
    )
  )
)

(extendJoy 'define
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (extendJoy top0 top1)
      rest
    )
  )
)

(extendJoy 'definitions
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
