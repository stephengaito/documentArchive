#lang racket

(require racketJoy/internals)

;; Core Operators
;;
(extendJoy 'newstack 
  (lambda (aStack)
    '()
  )
)

(extendJoy 'dup
  (lambda (aStack)
    (cons (car aStack) aStack)
  )
)

(extendJoy 'pop
  (lambda (aStack)
    (cdr aStack)
  )
)


;; Core Combinators
;;
(extendJoy 'i
  (lambda (aStack)
    (let ([ top  (car aStack) ]
          [ rest (cdr aStack) ])
      (evalCmdListOnStack top rest)
    )
  )
)

(extendJoy 'ifte
  (lambda (aStack)
    (let ([ top0 (car   aStack) ]
          [ top1 (cadr  aStack) ]
          [ top2 (caddr aStack) ]
          [ rest (cdddr aStack) ])
      (if
        (car (evalCmdListOnStack top2 rest))
        (evalCmdListOnStack top1 rest)
        (evalCmdListOnStack top0 rest)
      )
    )
  )
)

