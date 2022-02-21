#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require
  "../namesData.rkt"
)

(define all-tests
  (test-suite  "Names"
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

  )
)

(define ignore-value (run-tests all-tests 'verbose))
