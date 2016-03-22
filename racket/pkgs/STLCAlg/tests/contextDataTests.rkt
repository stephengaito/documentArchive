#lang racket/base

(require rackunit rackunit/text-ui)

(require
  "../typesData.rkt"
  "../contextsData.rkt"
)

(define all-tests
  (test-suite "Contexts, Environments, Kinds, Info"

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

    (test-case "Test Environments (Contexts)"
      (let* (
        [ emptyEnv  (empty-env) ]
        [ aTypeName (global-name "aTypeName") ]
        [ aType     (tfree-type aTypeName) ]
        [ anInfo    (type-info aType) ]
        [ aVarName0 (global-name "aVarName0") ]
        [ aVarName1 (global-name "aVarName1") ]
        [ extendEnv (extend-env aVarName0 anInfo emptyEnv) ]
            )

        (check-false (env? 1))

        (check-true  (env? emptyEnv))
        (check-true  (empty-env? emptyEnv))
        (check-false (empty-env? 1))

        (check-true  (env? extendEnv))
        (check-true  (extend-env? extendEnv))
        (check-false (extend-env? emptyEnv))
        (check-false (extend-env? 1))
        (check-eq?   (extend-env-name extendEnv) aVarName0)
        (check-eq?   (extend-env-info extendEnv) anInfo)
        (check-eq?   (extend-env-next extendEnv) emptyEnv)

        (check-eq?   (get-info-env extendEnv aVarName0) anInfo)
        (check-eq?   (get-info-env extendEnv aVarName1) null)
        (check-eq?   (get-info-env emptyEnv  aVarName0) null)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

