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
  (begin 

    (test-suite "Describe the specification of diSimp"

      (test-case "Show that diSimp is a function from lists to lists"
        (check-true (list? (diSimp '(() ()) )))
      )

      (test-case "Noop simply returns the stack"
        (let* ([ noop-list (list diSimp::noop '() ) ]
               [ result (diSimp noop-list) ])
          (check-true (list? noop-list))
          (check-true (list? result))
          (check-equal? result noop-list)
        )
      )

      (test-case "pop takes the top off the stack"
        (let* ([ pop-list (list diSimp::pop '() '() ) ]
               [ result (diSimp pop-list) ])
          (check-true (list? pop-list))
          (check-true (list? result))
          (check-not-equal? result pop-list)
          (check-equal? result '(() ()))
        )
      )

      (test-case "stack pushes the current stack onto the top of the stack"
        (let* ([ stack-list (list diSimp::stack '() '() ) ]
               [ result (diSimp stack-list) ])
          (check-equal? result '(() (() ()) () ()) )
        )
      )

      (test-case "unStack replaces the stack with the current top of the stack"
        (let* ([ unStack-list (list diSimp::unStack '() '() ) ]
               [ result (diSimp unStack-list) ])
          (check-equal? result '(() ()) )
        )
      )

      (test-case "newStack empties the stack"
        (let* ([ newStack-list (list diSimp::newStack '() '() ) ]
               [ result (diSimp newStack-list) ])
          (check-equal? result '(() ()) )
        )
      )
    )
  )
)

(define ingnore-value (run-tests all-tests 'verbose))
