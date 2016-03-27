#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require racket/pretty)

(require
  "../namesData.rkt"
  "../typesData.rkt"
  "../termsData.rkt"
  "../valuesData.rkt"
)

(define all-tests
  (test-suite "Neutral, Values and Environments"

    (test-case "Test neutral data structures"
      (let* (
        [ aNameStr "aName" ]
        [ aName    (global-name aNameStr) ]
        [ nFree    (nfree-neutral aName) ]
        [ aValue   (vneutral-value nFree) ]
        [ nApp     (napp-neutral nFree aValue) ]
            )
        (check-false (neutral? aName))
        (check-false (neutral? 1))

        (check-true  (neutral? nFree))
        (check-true  (nfree-neutral? nFree))
        (check-false (nfree-neutral? nApp))
        (check-false (nfree-neutral? aName))
        (check-eq?   (nfree-neutral-name nFree) aName)

        (check-true  (neutral? nApp))
        (check-true  (napp-neutral? nApp))
        (check-false (napp-neutral? nFree))
        (check-false (napp-neutral? aName))
        (check-eq?   (napp-neutral-func nApp) nFree)
        (check-eq?   (napp-neutral-arg nApp)  aValue)
      )
    )

    (test-case "Test values data structures"
      (let* (
        [ aLambdaFunc (lambda (x) x) ]
        [ anArgName   (global-name "anArgName") ]
        [ vLam        (vlam-value aLambdaFunc) ]
        [ aNeutral    (nfree-neutral anArgName) ]
        [ vNeutral    (vneutral-value aNeutral) ]
            )
        (check-false (value? anArgName))
        (check-false (value? 1))

        (check-true  (value? vLam))
        (check-true  (vlam-value? vLam))
        (check-false (vlam-value? vNeutral))
        (check-false (vlam-value? 1))
        (check-eq?   (vlam-value-func vLam) aLambdaFunc)

        (check-true  (value? vNeutral))
        (check-true  (vneutral-value? vNeutral))
        (check-false (vneutral-value? vLam))
        (check-false (vneutral-value? 1))
        (check-eq?   (vneutral-value-neutral vNeutral) aNeutral)
      )
    )

    (test-case "Test environment data structures"
      (let* (
        [ emptyEnv    (empty-env) ]
        [ extendEnv01 (extend-env 1 emptyEnv) ]
        [ extendEnv02 (extend-env 2 extendEnv01) ]
            )
        (check-false (env? 1))

        (check-true  (env? emptyEnv))
        (check-true  (empty-env? emptyEnv))
        (check-false (empty-env? extendEnv01))
        (check-false (empty-env? 1))

        (check-true  (env? extendEnv01))
        (check-true  (extend-env? extendEnv01))
        (check-false (extend-env? emptyEnv))
        (check-false (extend-env? 1))
        (check-eq?   (extend-env-value extendEnv02) 2)
        (check-eq?   (get-index-env 0 extendEnv02) 2)
        (check-eq?   (get-index-env 1 extendEnv02) 1)
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))

