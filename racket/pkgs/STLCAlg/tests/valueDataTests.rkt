#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require
  "../typesData.rkt"
  "../termsData.rkt"
  "../valuesData.rkt"
)

(define all-tests
  (test-suite "Neutral and Values"

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
        [ aFuncName (global-name "aFuncName") ]
        [ anArgName (global-name "anArgName") ]
        [ vLam      (vlam-value aFuncName anArgName) ]
        [ aNeutral  (nfree-neutral anArgName) ]
        [ vNeutral  (vneutral-value aNeutral) ]
            )
        (check-false (value? aFuncName))
        (check-false (value? 1))

        (check-true  (value? vLam))
        (check-true  (vlam-value? vLam))
        (check-false (vlam-value? vNeutral))
        (check-false (vlam-value? 1))
        (check-eq?   (vlam-value-func vLam) aFuncName)
        (check-eq?   (vlam-value-arg  vLam) anArgName)

        (check-true  (value? vNeutral))
        (check-true  (vneutral-value? vNeutral))
        (check-false (vneutral-value? vLam))
        (check-false (vneutral-value? 1))
        (check-eq?   (vneutral-value-neutral vNeutral) aNeutral)
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))

