#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require 
  "../types.rkt"
)

(define verbose-mode (make-parameter #f))

(define all-tests
  (test-suite  "Types"

    (test-case "Test types data structures"
      (let* (
        [ baseType (tfree-type "baseType") ]
        [ funcType (func-type baseType baseType) ]
            )
        (check-true (type? baseType))
        (check-true (type? funcType))
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
