#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require racket/pretty)

(require 
  "../types.rkt"
  "../terms.rkt"
)

(define verbose-mode (make-parameter #f))

(define all-tests
  (test-suite  "Terms"

    (test-case "Test terms data structures"
      (let* (
        [ baseType      (tfree-type "baseType") ]
        [ aBoundTerm    (bnd-term 1) ]
        [ anAnnotation  (ann-term aBoundTerm baseType) ]
        [ aFreeTerm     (free-term "varName") ]
        [ aLambdaTerm   (lam-term aBoundTerm) ]
        [ anApplication (app-term aLambdaTerm aBoundTerm) ]
            )
        (check-true   (type? baseType))

        (check-true   (term? aBoundTerm))
        (check-true   (inf-term? aBoundTerm))
        (check-false  (chk-term? aBoundTerm))
        (check-true   (bnd-term? aBoundTerm))
        (check-false  (bnd-term? anAnnotation))
        (check-false  (bnd-term? 1))
        (check-eq?    (bnd-term-index aBoundTerm) 1)

        (check-true   (term? anAnnotation))
        (check-true   (inf-term? anAnnotation))
        (check-false  (chk-term? anAnnotation))
        (check-true   (ann-term? anAnnotation))
        (check-false  (ann-term? aBoundTerm))
        (check-false  (ann-term? 1))
        (check-eq?    (ann-term-term anAnnotation) aBoundTerm)
        (check-eq?    (ann-term-type anAnnotation) baseType)

        (check-true   (term? aFreeTerm))
        (check-true   (inf-term? aFreeTerm))
        (check-false  (chk-term? aFreeTerm))
        (check-true   (free-term? aFreeTerm))
        (check-false  (free-term? aBoundTerm))
        (check-false  (free-term? 1))
        (check-equal? (free-term-name aFreeTerm) "varName")

        (check-true   (term? aLambdaTerm))
        (check-false  (inf-term? aLambdaTerm))
        (check-true   (chk-term? aLambdaTerm))
        (check-true   (lam-term? aLambdaTerm))
        (check-false  (lam-term? aBoundTerm))
        (check-false  (lam-term? 1))
        (check-eq?    (lam-term-term aLambdaTerm) aBoundTerm)

        (check-true   (term? anApplication))
        (check-true   (inf-term? anApplication))
        (check-false  (chk-term? anApplication))
        (check-true   (app-term? anApplication))
        (check-false  (app-term? aBoundTerm))
        (check-false  (app-term? 1))
        (check-eq?    (app-term-func anApplication) aLambdaTerm)
        (check-eq?    (app-term-arg  anApplication) aBoundTerm)
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
