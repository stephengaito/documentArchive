#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require
  "../typesData.rkt"
  "../termsData.rkt"
  "../valuesData.rkt"
)

(define all-tests
  (test-suite "Value evaluation"

    (test-case "Test eval proceedures"
      (let* (
        [ something "something" ]
            )
        (check-true #t)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

