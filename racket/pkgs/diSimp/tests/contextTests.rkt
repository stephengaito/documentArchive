#lang racket/base

(require rackunit rackunit/text-ui)

(require
  "../types.rkt"
  "../contexts.rkt"
)

(define all-tests
  (test-suite "Contexts, Kinds, Info"

    (test-case "Test Kinds"
      (let* (
        [ aKind (kind) ]
            )

        (check-true (kind? aKind))
      )
    )

    (test-case "Test Info"
      (let* (
        [ aKind    (kind) ]
        [ kindInfo (kind-info aKind) ]
        [ aName    (global-name "aName") ]
        [ aType    (tfree-type aName) ]
        [ typeInfo (type-info aType) ]
            )

        (check-false (info? 1))

        (check-true  (info? kindInfo))
        (check-true  (kind-info? kindInfo))
        (check-false (kind-info? typeInfo))
        (check-false (kind-info? 1))
        (check-eq?   (kind-info-kind kindInfo) aKind)

        (check-true  (info? typeInfo))
        (check-true  (type-info? typeInfo))
        (check-false (type-info? kindInfo))
        (check-false (type-info? 1))
        (check-eq?   (type-info-type typeInfo) aType)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

