#lang racket

(require racketJoy/coreJoy)

(displayln "Loaded basicJoy")

(extendJoy 'silly
  '(silly sillier silliest )
)

(extendJoy 'newStack 
  (lambda (aStack)
    '()
  )
)

(extendJoy '+
  (lambda (aStack)
    (let ([ top0 (car aStack)  ]
          [ top1 (cadr aStack) ]
          [ rest (cddr aStack) ])
      (cons (+ top0 top1) rest)
    )
  )
)

