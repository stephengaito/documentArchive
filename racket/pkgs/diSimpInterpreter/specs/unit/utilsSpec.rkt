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
    )

  )
)

(define ingnore-value (run-tests all-tests 'verbose))
