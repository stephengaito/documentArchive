#lang racket

(require racketJoy/internals)

;; Core Operators
;;
(extendJoy ('newStack aStack)
  '()
)

(extendJoy ('dup aStack)
  (cons (car aStack) aStack)
)

(extendJoy1 ('pop top1 rest)
  rest
)

(extendJoy2 ('swap top1 top2 rest)
  (cons top2 (cons top1 rest))
)

(extendJoy2 ('cons top1 top2 rest)
  (cons (cons top2 top1) rest)
)

(extendJoy2 ('concat top1 top2 rest)
  (cons (append top2 top1) rest)
)

;; Core Combinators
;;
(extendJoy1 ('i top1 rest)
  (evalCmdListOnStack top1 rest)
)

(extendJoy3 ('ifte top1-else top2-then top3-if rest)
  (if
    (car (evalCmdListOnStack top3-if rest))
    (evalCmdListOnStack top2-then rest)
    (evalCmdListOnStack top1-else rest)
  )
)

(extendJoy2 ('dip top1 top2 rest)
  (cons top2 (evalCmdListOnStack top1 rest))
)

(extendJoy2 ('map top1 top2 rest)
  (cons
    (map
      (lambda (anItem)
        (car (evalCmdListOnStack top1 (cons anItem rest)))
      )
      top2
    )
    rest
  )
)


