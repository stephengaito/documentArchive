#lang racket

(require racketJoy/internals)

(extendJoy ('+ aStack)
  (let ([ top0 (car  aStack) ]
        [ top1 (cadr aStack) ]
        [ rest (cddr aStack) ])
    (cons (+ top1 top0) rest)
  )
)

(extendJoy ('- aStack)
  (let ([ top0 (car  aStack) ]
        [ top1 (cadr aStack) ]
        [ rest (cddr aStack) ])
    (cons (- top1 top0) rest)
  )
)

(extendJoy ('* aStack)
  (let ([ top0 (car  aStack) ]
        [ top1 (cadr aStack) ]
        [ rest (cddr aStack) ])
    (cons (* top1 top0) rest)
  )
)

(extendJoy ('= aStack)
  (let ([ top0 (car  aStack) ]
        [ top1 (cadr aStack) ]
        [ rest (cddr aStack) ])
    (cons (eq? top1 top0) rest)
  )
)

(defineJoy 'factorial
  ((0 =) (pop 1) (dup 1 - factorial *) ifte)
)

(displayln "Loaded basicJoy")

