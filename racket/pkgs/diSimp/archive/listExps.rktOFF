#lang racket/base

(provide
  list-exp?
  null-list-exp?
  null-list-exp
  cons-list-exp?
  cons-list-exp
  cons-exp-car
  cons-exp-cdr
  car-list-exp?
  car-list-exp
  car-exp
  cdr-list-exp?
  cdr-list-exp
  cdr-exp
)

;; List expressions
;;
(define (list-exp? listExp)
  (case (car listExp)
    [ (null) (eq? (length listExp) 1) ]
    [ (cons) (eq? (length listExp) 3) ]
    [ (car)  (eq? (length listExp) 2) ]
    [ (cdr)  (eq? (length listExp) 2) ]
    [ else #f ]
  )
)

;; Null/Empty lists
;;
(define (null-list-exp? listExp)
  (and (eq? (car listExp) 'null)
    (eq? (length listExp) 1)
  )
)

(define (null-list-exp)
  '( null )
)

;; Cons lists
;;
(define (cons-list-exp? listExp)
  (and (eq? (car listExp) 'cons)
    (eq? (length listExp) 3)
  )
)

(define (cons-list-exp listExp1 listExp2)
  (list 'cons listExp1 listExp2)
)

(define (cons-exp-car listExp)
  (cadr listExp)
)

(define (cons-exp-cdr listExp)
  (caddr listExp)
)

;; Car lists
;;
(define (car-list-exp? listExp)
  (and (eq? (car listExp) 'car)
    (eq? (length listExp) 2)
  )
)

(define (car-list-exp listExp1)
  (list 'car listExp1)
)

(define (car-exp listExp)
  (cadr listExp)
)

;; Cdr lists
;;
(define (cdr-list-exp? listExp)
  (and (eq? (car listExp) 'cdr)
    (eq? (length listExp) 2)
  )
)

(define (cdr-list-exp listExp1)
  (list 'cdr listExp1)
)

(define (cdr-exp listExp)
  (cadr listExp)
)
