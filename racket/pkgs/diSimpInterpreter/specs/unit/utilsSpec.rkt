#lang racket

;; Goal: show that diSimp is a function from lists to lists

;; Story: anything will do

(require 
  rackunit
  rackunit/text-ui
)

(require
  diSimpInterpreter
  (submod diSimpInterpreter/utils privateAPI)
)

(define all-tests
  (begin 

    (test-suite "Test utils/privateAPI"
      (test-case "diSimpTag counts correctly"
        (check-equal? (diSimpTag 0) '() )
        (check-equal? (diSimpTag 1) '(()) )
        (check-equal? (diSimpTag 2) '((())) )
        (check-equal? (diSimpTag 3) '(((()))) )
      )

      (test-case "biStream next moves into the future"
        (let ([ aBiStream '(() 1 2 3 4 5)])
            (check-equal? (next aBiStream) '((1) 2 3 4 5) )
            (check-equal? (next (next aBiStream)) '((2 1)  3 4 5))
            (check-equal? (next (next (next aBiStream))) '((3 2 1) 4 5))
        )
      )

      (test-case "biStream previous moves into the past"
        (let ([ aBiStream '((5 4 3 2 1) )])
            (check-equal? (previous aBiStream) '((4 3 2 1) 5) )
            (check-equal? (previous (previous aBiStream)) '((3 2 1)  4 5))
            (check-equal? (previous (previous (previous aBiStream))) '((2 1) 3 4 5))
        )
      )

      (test-case "biStream next/previous invariants"
        (let ([ aBiStream '((3 2 1) 4 5)])
            (check-equal? (next (previous aBiStream)) aBiStream )
            (check-equal? (previous (next aBiStream)) aBiStream )
        )
      )
    )

  )
)

(define ingnore-value (run-tests all-tests 'verbose))
