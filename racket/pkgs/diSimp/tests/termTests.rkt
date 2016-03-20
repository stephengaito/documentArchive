#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require "../terms.rkt")

(define verbose-mode (make-parameter #f))

(define all-tests
  (test-suite  "Terms"

    (test-case "Test terms data structures"
      (let* ([ aTerm '()]
            )
        (check-true (term? aTerm))
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
