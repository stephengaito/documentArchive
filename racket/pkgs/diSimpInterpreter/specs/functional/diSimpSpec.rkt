#lang racket

;; Goal: show that diSimp is a function from lists to lists

;; Story: anything will do

(require 
  rackunit
  rackunit/text-ui
)

(require
  diSimpInterpreter
)

(define all-tests
  (test-suite "Describe the specification of diSimp"
    (test-case "Show that diSimp is a function from lists to lists"
      (check-true (list? (diSimp '())))
    )
  )
)

(define ingnore-value (run-tests all-tests 'verbose))
