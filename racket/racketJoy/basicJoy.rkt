#lang racket

(require racketJoy/internals)

(extendJoy2 ('+ top1 top2 rest)
  (cons (+ top2 top1) rest)
)

(extendJoy2 ('- top1 top2 rest)
  (cons (- top2 top1) rest)
)

(extendJoy2 ('* top1 top2 rest)
  (cons (* top2 top1) rest)
)

(extendJoy2 ('= top1 top2 rest)
  (cons (eq? top2 top1) rest)
)

(defineJoy 'factorial
  ((0 =) (pop 1) (dup 1 - factorial *) ifte)
)

(displayln "Loaded basicJoy")

