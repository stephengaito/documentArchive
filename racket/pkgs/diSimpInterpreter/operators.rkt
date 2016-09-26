#lang diSimpRacketLayer

(provide 
  noop
  pop
  stack
  unStack
  newStack
)

(module+ privateAPI
  (provide
    diSimpCount
    noopList
    noopOp
    popList
    popOp
    stackList
    stackOp
    unStackList
    unStackOp
    newStackList
    newStackOp
  )
)

;; creates a diSimp::tag of the appropriate value
;;
(define (diSimpCount aValue) 
  (if (positive? aValue)
    (list '() (diSimpCount (- aValue 1)))
    '()
  )
)

;; makes no change to the stack
;;
(define noop (diSimpCount 0) )
(define noopList (list noop) )
(define (noopOp aStack) aStack)

;; pops the top of the stack off
;;
(define pop  (diSimpCount 1) )
(define popList (list pop) )
(define (popOp aStack) (cdr aStack) )

;; pushes the current stack onto the top of the stack
;;
;; is this too powerful?
;;
(define stack (diSimpCount 2) )
(define stackList (list stack) )
(define (stackOp aStack) (cons aStack aStack) )

;; replaces the stack with the current top of the stack
;;
(define unStack (diSimpCount 3) )
(define unStackList (list unStack) )
(define (unStackOp aStack) (list (car aStack)) )

;; empties the stack
;;
(define newStack (diSimpCount 4) )
(define newStackList (list newStack) )
(define (newStackOp aStack) '(()) )
