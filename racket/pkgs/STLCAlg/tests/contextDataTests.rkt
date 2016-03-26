#lang racket/base

(require rackunit rackunit/text-ui)

(require
  "../typesData.rkt"
  "../contextsData.rkt"
)

(define all-tests
  (test-suite "Contexts, Contexts, Kinds, Info"

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

    (test-case "Test Contexts"
      (let* (
        [ emptyCxt  (empty-cxt) ]
        [ aTypeName (global-name "aTypeName") ]
        [ aType     (tfree-type aTypeName) ]
        [ anInfo    (type-info aType) ]
        [ aVarName0 (global-name "aVarName0") ]
        [ aVarName1 (global-name "aVarName1") ]
        [ extendCxt (extend-cxt aVarName0 anInfo emptyCxt) ]
            )

        (check-false (cxt? 1))

        (check-true  (cxt? emptyCxt))
        (check-true  (empty-cxt? emptyCxt))
        (check-false (empty-cxt? 1))

        (check-true  (cxt? extendCxt))
        (check-true  (extend-cxt? extendCxt))
        (check-false (extend-cxt? emptyCxt))
        (check-false (extend-cxt? 1))
        (check-eq?   (extend-cxt-name extendCxt) aVarName0)
        (check-eq?   (extend-cxt-info extendCxt) anInfo)
        (check-eq?   (extend-cxt-next extendCxt) emptyCxt)

        (check-eq?   (get-info-cxt extendCxt aVarName0) anInfo)
        (check-eq?   (get-info-cxt extendCxt aVarName1) null)
        (check-eq?   (get-info-cxt emptyCxt  aVarName0) null)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

