#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require doc-coverage)

(require "../listExps.rkt")

(define all-tests
  (test-suite  "ListExps"
    (test-case  "null-list-exp?"
      (let ([null-lst '(null)]
            [lst '( () ())]
           )
        (check-true  (null-list-exp? null-lst))
        (check-false (null-list-exp? lst))
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
