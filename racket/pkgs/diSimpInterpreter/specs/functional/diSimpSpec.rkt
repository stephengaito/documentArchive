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

    (test-case "Noop simply returns the list"
      (let* ([ noop-list '(() ()) ]
             [ result (diSimp noop-list) ])
        (check-true (list? noop-list))
        (check-true (list? result))
        (check-equal? noop-list result)
      )
    )

    (test-case "pop takes the top off the list"
      (let* ([ pop-list '(() ()) ]
             [ result (diSimp noop-list) ])
        (check-true (list? noop-list))
    )
  )
)

(define ingnore-value (run-tests all-tests 'verbose))
