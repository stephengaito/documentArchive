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
        (let* ([ noop-list (list diSimp::noopTag '() ) ]
               [ result (diSimp noop-list) ])
          (check-true (list? noop-list))
          (check-true (list? result))
          (check-equal? result noop-list)
        )
      )

      (test-case "pop takes the top off the stack"
        (let* ([ pop-list (list diSimp::popTag '() '() ) ]
               [ result (diSimp pop-list) ])
          (check-true (list? pop-list))
          (check-true (list? result))
          (check-not-equal? result pop-list)
          (check-equal? result '(() ()))
        )
      )

      (test-case "cons pops the top two items off the stack and replaces them with their cons"
        (let* ([ cons-list (list diSimp::consTag '() '() '() ) ]
               [ result (diSimp cons-list) ])
          (check-equal? result '(() (() ()) ()) )
        )
      )

      (test-case "tree pushes the current tree onto the top of the tree"
        (let* ([ tree-list (list diSimp::treeTag '() '() ) ]
               [ result (diSimp tree-list) ])
          (check-equal? result '(() (() ()) () ()) )
        )
      )

      (test-case "unStack replaces the stack with the current top of the stack"
        (let* ([ unTree-list (list diSimp::unTreeTag '() '() ) ]
               [ result (diSimp unTree-list) ])
          (check-equal? result '(() ()) )
        )
      )

      (test-case "newStack empties the stack"
        (let* ([ newTree-list (list diSimp::newTreeTag '() '() ) ]
               [ result (diSimp newTree-list) ])
          (check-equal? result '(() ()) )
        )
      )
    )
  )
)

;;	(define ingnore-value (run-tests all-tests 'verbose))
