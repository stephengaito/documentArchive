#lang racket

(require racketJoy/internals)

(extendJoy 'load
  (lambda (aStack)
    (let ([ top0 (car aStack) ]
          [ rest (cdr aStack) ])
      (dynamic-require top0 #f)
      rest
    )
  )
)

(extendJoy 'newStack 
  (lambda (aStack)
    '()
  )
)

