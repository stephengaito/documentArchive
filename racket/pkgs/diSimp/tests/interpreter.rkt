#lang racket/base

(require rackunit)
(require rackunit/text-ui)

;(define all-tests
;  (test-suite
;   "Tests for interpreter.rkt"
;    (check-equal? 1 1 "simple test")
;    (test-case
;     "List has length 4 and all elements even"
;      (let ([lst (list 2 4 6 9)])
;        (check = (length lst) 4)
;        (for-each
;          (lambda (elt)
;            (check-pred even? elt)
;          )
;          lst
;        )
;      )
;    )
;  )
;)

;(run-tests all-tests)
