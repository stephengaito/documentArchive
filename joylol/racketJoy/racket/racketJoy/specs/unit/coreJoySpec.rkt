#lang racket

;; Goal: show that the individual joy operators/combinators correctly 
;; manipulate the stack

;; TODO: we have only tested the happy paths ;-(

(require
  rackunit
  "../utils.rkt"
)

(require
  racketJoy/internals
  (submod racketJoy/internals privateAPI)
  racketJoy/coreJoy
  racketJoy/basicJoy
)

(define test-operators
  (test-suite "Test Joy Operators"
    (test-case "newStack"
      (check-equal? (evalStack '(newStack 1 2 3 4)) '())
    )

    (test-case "dup"
      (check-equal? (evalStack '(dup 1)) '(1 1))
    )

    (test-case "pop"
      (check-equal? (evalStack '(pop 1 2)) '(2))
    )

    (test-case "swap"
      (check-equal? (evalStack '(swap 1 2)) '(2 1))
    )

    (test-case "cons"
      (check-equal? (evalStack '(cons (2 3 4) 1)) '((1 2 3 4 )))
    )

    (test-case "concat"
      (check-equal? (evalStack '(concat (4 5 6) (1 2 3))) '((1 2 3 4 5 6)))
    )
  )
)


(define test-combinators
  (test-suite "Test Joy Combinators"
    (test-case "i"
      (check-equal? (evalStack '(i (dup *) 5)) '(25))
    )

    (test-case "ifte"
      (check-equal? (evalStack '(ifte (2) (1) (0 =) 0)) '(1 0))
      (check-equal? (evalStack '(ifte (2) (1) (0 =) 5)) '(2 5))
    )

    (test-case "dip"
      (check-equal? (evalStack '(dip (dup *) 1 5)) '(1 25))
    )

    (test-case "map"
      (check-equal? (evalStack '(map (dup *) (1 2 3 4))) '((1 4 9 16)))
    )
  )
)


(run-test-suites (list test-operators test-combinators))
