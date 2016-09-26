#lang diSimpRacketLayer

(require (submod diSimpInterpreter/utils privateAPI))

(provide 
  noopTag
  popTag
  consTag
  stackTag
  unStackTag
  newStackTag
)

(module+ privateAPI
  (provide
    noopList
    noopOp
    popList
    popOp
    consList
    consOp
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
(define noopTag (diSimpTag 0) )
(define noopList (list noopTag) )
(define (noopOp aStack) aStack)

;; pops the top of the stack off
;;
(define popTag  (diSimpTag 1) )
(define popList (list popTag) )
(define (popOp aStack) (cdr aStack) )

;; pops the top two items on the stack
;; and replaces them with their cons
;;
(define consTag (diSimpTag 2) )
(define consList (list consTag) )
(define (consOp aStack)
  (cons (list (car aStack) (cadr aStack)) (cddr aStack))
)

;; pushes the current stack onto the top of the stack
;;
;; is this too powerful?
;;
(define stackTag (diSimpTag 3) )
(define stackList (list stackTag) )
(define (stackOp aStack) (cons aStack aStack) )

;; replaces the stack with the current top of the stack
;;
(define unStackTag (diSimpTag 4) )
(define unStackList (list unStackTag) )
(define (unStackOp aStack) (list (car aStack)) )

;; empties the stack
;;
(define newStackTag (diSimpTag 5) )
(define newStackList (list newStackTag) )
(define (newStackOp aStack) '(()) )
