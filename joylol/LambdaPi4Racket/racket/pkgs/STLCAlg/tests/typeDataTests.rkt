#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require 
  "../namesData.rkt"
  "../typesData.rkt"
)

(define all-tests
  (test-suite  "Types"
    (test-case "Test types data structures"
      (let* (
        [ baseName   (global-name "baseType") ]
        [ baseType   (tfree-type baseName) ]
        [ domainName (global-name "domainName") ]
        [ domainType (tfree-type domainName) ]
        [ rangeName  (global-name "rangeName") ]
        [ rangeType  (tfree-type rangeName) ]
        [ funcType (func-type domainType rangeType) ]
            )

        (check-false (type? baseName))

        (check-true  (type? baseType))
        (check-true  (tfree-type? baseType))
        (check-false (tfree-type? funcType))
        (check-false (tfree-type? baseName))
        (check-eq?   (tfree-type-name baseType) baseName)

        (check-true  (type? funcType))
        (check-true  (func-type? funcType))
        (check-false (func-type? baseType))
        (check-false (func-type? baseName))
        (check-eq?   (func-type-domain funcType) domainType)
        (check-eq?   (func-type-range  funcType) rangeType)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))
