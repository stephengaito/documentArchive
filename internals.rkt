#lang racket

(provide 
  extendJoy
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

(define (pushCommandListOnStack commandList aStack)
  (if (null? commandList)
    aStack
    (pushCommandListOnStack 
      (cdr commandList) (cons (car commandList) aStack))
  )
) 

(define (evalSymbol command aStack)
  (let ([ cmdImpl (hash-ref joyTable command 'unknown) ])
    (cond
      [ (procedure? cmdImpl) (apply cmdImpl (list aStack))
      ] [ (list? cmdImpl)    (cons cmdImpl aStack)
      ] [ else 
        (begin
          (displayln 
            (string-append "undefined command [" (~a command) "]"))
          (cons command aStack)
        )
      ]
    )
  )
)

(define (evalStack aStack) 
  (let ( [ command (car aStack) ]
         [ rest    (cdr aStack) ] )
    (cond
      [ (list? command)
        (evalStack (pushCommandListOnStack command rest) ) 
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
  (set! joyStack 
    (if (eq? someArgs 'eval)
      (evalStack joyStack)
      (cons someArgs joyStack)
    )
  )
  (displayln joyStack)
)
