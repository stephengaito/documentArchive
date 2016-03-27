#lang racket/base

(require rackunit rackunit/text-ui)

(require
  "../typesData.rkt"
  "../typesCtxData.rkt"
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
        [ emptyCtx  (empty-ctx) ]
        [ aTypeName (global-name "aTypeName") ]
        [ aType     (tfree-type aTypeName) ]
        [ anInfo    (type-info aType) ]
        [ aVarName0 (global-name "aVarName0") ]
        [ aVarName1 (global-name "aVarName1") ]
        [ extendCtx (extend-ctx aVarName0 anInfo emptyCtx) ]
            )

        (check-false (ctx? 1))

        (check-true  (ctx? emptyCtx))
        (check-true  (empty-ctx? emptyCtx))
        (check-false (empty-ctx? 1))

        (check-true  (ctx? extendCtx))
        (check-true  (extend-ctx? extendCtx))
        (check-false (extend-ctx? emptyCtx))
        (check-false (extend-ctx? 1))
        (check-eq?   (extend-ctx-name extendCtx) aVarName0)
        (check-eq?   (extend-ctx-info extendCtx) anInfo)
        (check-eq?   (extend-ctx-next extendCtx) emptyCtx)

        (check-eq?   (get-info-ctx extendCtx aVarName0) anInfo)
        (check-eq?   (get-info-ctx extendCtx aVarName1) null)
        (check-eq?   (get-info-ctx emptyCtx  aVarName0) null)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

