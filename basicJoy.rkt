#lang racket

(require racketJoy/internals)

(displayln "Loaded basicJoy")

(extendJoy '+
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (+ top1 top0) rest)
    )
  )
)

(extendJoy '-
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (- top1 top0) rest)
    )
  )
)

(extendJoy '*
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (* top1 top0) rest)
    )
  )
)

(extendJoy '=
  (lambda (aStack)
    (let ([ top0 (car  aStack) ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (eq? top1 top0) rest)
    )
  )
)

(extendJoy 'factorial
  '((0 =) (pop 1) (dup 1 - factorial *) ifte)
)
