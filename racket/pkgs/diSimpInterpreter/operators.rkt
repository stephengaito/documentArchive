#lang diSimpRacketLayer

(require (submod diSimpInterpreter/utils privateAPI))

(provide 
  noop
  pop
  stack
  unStack
  newStack
)

(module+ privateAPI
  (provide
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

;; makes no change to the stack
;;
(define noop (diSimpTag 0) )
(define noopList (list noop) )
(define (noopOp aStack) aStack)

;; pops the top of the stack off
;;
(define pop  (diSimpTag 1) )
(define popList (list pop) )
(define (popOp aStack) (cdr aStack) )

;; pushes the current stack onto the top of the stack
;;
;; is this too powerful?
;;
(define stack (diSimpTag 2) )
(define stackList (list stack) )
(define (stackOp aStack) (cons aStack aStack) )

;; replaces the stack with the current top of the stack
;;
(define unStack (diSimpTag 3) )
(define unStackList (list unStack) )
(define (unStackOp aStack) (list (car aStack)) )

;; empties the stack
;;
(define newStack (diSimpTag 4) )
(define newStackList (list newStack) )
(define (newStackOp aStack) '(()) )
