#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require 
  "../typesData.rkt"
)

(define all-tests
  (test-suite  "Names and Types"

    (test-case "Test names data structures"
      (let* (
        [ aNameStr    "aNameString" ]
        [ aGlobalName (global-name aNameStr) ]
        [ aLocalName  (local-name 1) ]
        [ aQuoteName  (quote-name 1) ]
            )
        (check-false (name? aNameStr))

        (check-true  (name? aGlobalName))
        (check-true  (global-name? aGlobalName))
        (check-false (global-name? aLocalName))
        (check-false (global-name? aNameStr))
        (check-eq?   (global-name-str aGlobalName) aNameStr)

        (check-true  (name? aLocalName))
        (check-true  (local-name? aLocalName))
        (check-false (local-name? aGlobalName))
        (check-false (local-name? aNameStr))
        (check-eq?   (local-name-index aLocalName) 1)

        (check-true  (name? aQuoteName))
        (check-true  (quote-name? aQuoteName))
        (check-false (quote-name? aGlobalName))
        (check-false (quote-name? aNameStr))
        (check-eq?   (quote-name-index aQuoteName) 1)
      )
    )

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
