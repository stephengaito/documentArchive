#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require racket/pretty)

(require
  "../namesData.rkt"
  "../typesData.rkt"
  "../typesCtxData.rkt"
  "../typesProc.rkt"
  "../termsData.rkt"
)

(define all-tests
  (test-suite  "Type Procs"

    (test-case "chk-kind"
      (let* (
        [ aTypeStr0  "aTypeName0" ]
        [ aTypeName0 (global-name aTypeStr0) ]
        [ aTFree0    (tfree-type aTypeName0) ]
        [ aTypeStr1  "aTypeName1" ]
        [ aTypeName1 (global-name aTypeStr1) ]
        [ aTFree1    (tfree-type aTypeName1) ]
        [ aTypeStr2  "aTypeName2" ]
        [ aTypeName2 (global-name aTypeStr2) ]
        [ aTFree2    (tfree-type aTypeName2) ]
        [ aTypeStr3  "aTypeName3" ]
        [ aTypeName3 (global-name aTypeStr3) ]
        [ aTFree3    (tfree-type aTypeName3) ]
        [ aVarStr0   "aVarName0" ]
        [ aVarName0  (global-name aVarStr0) ]
        [ aFreeTerm0 (free-term aVarName0) ]
        [ aVarStr1   "aVarName1" ]
        [ aVarName1  (global-name aVarStr1) ]
        [ aFreeTerm1 (free-term aVarName1) ]
        [ aVarStr2   "aVarName2" ]
        [ aVarName2  (global-name aVarStr2) ]
        [ aFreeTerm2 (free-term aVarName2) ]
        [ aFunc12    (func-type aTFree1 aTFree2) ]
        [ aFunc02    (func-type aTFree0 aTFree2) ]
        [ aFunc10    (func-type aTFree1 aTFree0) ]
        [ star       (kind) ]
        [ aLambda    (lam-term aFreeTerm0) ] 
        [ lamFunc    (ann-term aLambda aFunc12) ]
        [ anApp      (app-term lamFunc aFreeTerm1) ]
        [ anAnn      (ann-term aFreeTerm0 aTFree2) ]
        [ aCtx       (extend-ctx aTypeName0 (type-info star)
                       (extend-ctx aTypeName1 (kind-info aTFree1)
                         (extend-ctx aTypeName2 (kind-info star)
                           (extend-ctx aVarName0 (type-info aTFree2)
                             (extend-ctx aVarName1 (type-info aTFree1)
                               (empty-ctx)
                             )
                           )
                         )
                       )
                     ) ]
            )

        ;; chk-kind
        (check-true (chk-kind aCtx aTFree1 star))
        (check-exn exn-not-a-kind? 
          (lambda () (chk-kind aCtx aTFree0 star)) "aTFree0")
        (check-true (chk-kind aCtx aFunc12 star))
        (check-exn exn-not-a-kind? 
          (lambda () (chk-kind aCtx aFunc02 star)) "aFunc02")
        (check-exn exn-not-a-kind? 
          (lambda () (chk-kind aCtx aFunc10 star)) "aFunc10")
        (check-exn exn-name-not-found-in-context?
          (lambda () (chk-kind aCtx aTFree3 star))
        )

        ;; infer-rec-type (Free)
        (check-equal? (infer-rec-type 0 aCtx aFreeTerm0) aTFree2)
        (check-exn    exn-name-not-found-in-context?
          (lambda () (infer-rec-type 0 aCtx aFreeTerm2))
        )

        ;; chk-rec-type (Inf == Free)
        (check-true (chk-rec-type 0 aCtx aFreeTerm0 aTFree2))
        (check-exn  exn-type-mismatch?
          (lambda () (chk-rec-type 0 aCtx aFreeTerm0 aTFree1))
        )

        ;; chk-rec-type (Func)
        (check-true (chk-rec-type 0 aCtx aLambda aFunc12))
        (check-exn  exn-not-func-type?
          (lambda () (chk-rec-type 0 aCtx aLambda star))
        )
        (check-exn  exn-type-mismatch?
          (lambda () (chk-rec-type 0 aCtx aLambda aFunc10))
        )

        ;; infer-rec-type (Ann)
        (check-equal? (infer-rec-type 0 aCtx anAnn) aTFree2)

        ;; infer-rec-type (App) (happy path)
        (check-equal? (infer-rec-type 0 aCtx lamFunc) aFunc12)
        (check-true   (chk-rec-type 0 aCtx aFreeTerm1 aTFree1))
        (check-equal? (infer-rec-type 0 aCtx anApp) aTFree2)

        ;; infer-rec-type (App) (illegal-application)
        (check-equal? (infer-rec-type 0 aCtx aFreeTerm0) aTFree2)
        (check-exn    exn-illegal-application?
          (lambda () (infer-rec-type 0 aCtx (app-term aFreeTerm0 aFreeTerm1)))
        )

        ;; why is there no infer-rec-type (Bound)?

        ;; infer-type
        (check-equal? (infer-type aCtx lamFunc) aFunc12)
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))


