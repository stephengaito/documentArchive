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

(extendJoy 'swap
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons top1 (cons top0 rest))
    )
  )
)

(extendJoy 'cons
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (cons top1 top0) rest)
    )
  )
)

(extendJoy 'concat
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (append top1 top0) rest)
    )
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

(extendJoy 'dip
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons top1 (evalCmdListOnStack top0 rest))
    )
  )
)

(extendJoy 'map
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons
        (map
          (lambda (anItem)
            (car (evalCmdListOnStack top0 (cons anItem rest)))
          )
          top1
        )
        rest
      )
    )
  )
)


