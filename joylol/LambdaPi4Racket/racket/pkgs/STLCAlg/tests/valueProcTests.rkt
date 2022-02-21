#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require racket/pretty)

(require
  "../namesData.rkt"
  "../typesData.rkt"
  "../termsData.rkt"
  "../valuesData.rkt"
  "../valuesProc.rkt"
)

(define all-tests
  (test-suite "Value evaluation"

    (test-case "Test value-free proceedure"
      (let* (
        [ aName  (global-name "aName") ]
        [ aVFree (value-free aName) ]
            )
        (check-true (vneutral-value? aVFree))
      )
    )

    (test-case "Test value-app proceedure"
      (let* (
        [ aLambdaFunc (lambda (x) x) ]
        [ aVLam       (vlam-value aLambdaFunc) ]
        [ aName       (global-name "aName") ]
        [ anNFree     (nfree-neutral aName) ]
        [ aVNeutral   (vneutral-value anNFree) ]
        [ vApp10      (value-app aVNeutral 10) ]
            )
        (check-eq? (value-app aVLam 10) 10)
        (check-eq? (value-app aVLam "silly") "silly")
        (check-true (vneutral-value? vApp10))
        (check-true (napp-neutral? (vneutral-value-neutral vApp10)))
        (check-eq?  (napp-neutral-func (vneutral-value-neutral vApp10)) anNFree)
        (check-eq?  (napp-neutral-arg  (vneutral-value-neutral vApp10)) 10)
      )
    )

    (test-case "Test eval proceedure"
      (let* (
        [ bound00     (bnd-term 0) ]
        [ bound01     (bnd-term 1) ]
        [ bound02     (bnd-term 2) ]
        [ aVarStr     "aVarName" ]
        [ aVarName    (global-name aVarStr) ]
        [ aFreeTerm   (free-term aVarName) ]
        [ aTypeStr    "aTypeName" ]
        [ aTypeName   (global-name aTypeStr) ]
        [ aTFreeType  (tfree-type aTypeName) ]
        [ anAnnTerm   (ann-term bound02 aTFreeType) ]
        [ aLambdaFunc (lambda (x) x) ]
        [ aVLam       (vlam-value aLambdaFunc) ]
        [ aValueStr   "aValueName" ]
        [ aValueName  (global-name aValueStr) ]
        [ anNFree     (nfree-neutral aValueName) ]
        [ aVNeutral   (vneutral-value anNFree) ]
        [ anAppTerm   (app-term bound02 bound01) ]
        [ aLambdaTerm (lam-term bound01) ] ;; creates a constant function
        [ anEnv       (extend-env aFreeTerm 
                        (extend-env aVNeutral 
                          (extend-env aVLam (empty-env))
                        )
                      ) ]
            )
        ;; lp-eval bound terms
        (check-eq? (lp-eval bound00 anEnv) aFreeTerm)
        (check-eq? (lp-eval bound01 anEnv) aVNeutral)
        (check-eq? (lp-eval bound02 anEnv) aVLam)

        ;; lp-eval free terms
        (let ([ evalFree (lp-eval aFreeTerm anEnv) ])
          (check-true (vneutral-value? evalFree))
          (let ([ nFree (vneutral-value-neutral evalFree) ])
            (check-true (nfree-neutral? nFree))
            (check-eq?  (nfree-neutral-name nFree) aVarName)
          )
        )

        ;; lp-eval annotated terms
        (check-true (vlam-value? (lp-eval anAnnTerm anEnv)))
        (check-eq?  (vlam-value-func (lp-eval anAnnTerm anEnv)) aLambdaFunc)

        ;; lp-eval application terms
        (check-eq? (lp-eval anAppTerm anEnv) aVNeutral)

        ;; lp-eval lambda terms 
        (check-true (vlam-value? (lp-eval aLambdaTerm anEnv)))
        (check-eq?  (value-app (lp-eval aLambdaTerm anEnv) 1) aFreeTerm)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

