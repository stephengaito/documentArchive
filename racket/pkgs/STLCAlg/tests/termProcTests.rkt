#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require racket/pretty)

(require
  "../typesData.rkt"
  "../termsData.rkt"
  "../termsProc.rkt"
  "../valuesData.rkt"
)

(define all-tests
  (test-suite  "Term Procs (lp-quote rec-quote neutral-quote bound-free subst)"

    (test-case "Test bound-free neutral-quote rec-quote and lp-quote proceedures"
      (let* (
        [ aValueStr   "aValueName" ]
        [ aValueName  (global-name aValueStr) ]
        [ anNFree     (nfree-neutral aValueName) ]
        [ aVNeutral   (vneutral-value anNFree) ]
        [ aQuoteName  (quote-name 1) ]
        [ anNApp      (napp-neutral anNFree aVNeutral) ]
        [ aLambdaFunc (lambda (x) x) ]
        [ aVLam       (vlam-value aLambdaFunc) ]
            )

        ;; bound-free 
        (check-true (free-term? (bound-free 10 aValueName)))
        (check-eq?  (free-term-name (bound-free 10 aValueName)) aValueName)
        (check-true (bnd-term? (bound-free 10 aQuoteName)))
        (check-eq?  (bnd-term-index (bound-free 10 aQuoteName)) 8)

        ;; neutral-quote (NFree)
        (check-true (free-term? (neutral-quote 10 anNFree)))
        (check-eq?  (free-term-name (neutral-quote 10 anNFree)) aValueName)

        ;; neutral-quote (NApp)
        (check-true (app-term? (neutral-quote 2 anNApp)))
        (check-true (free-term? (app-term-func (neutral-quote 2 anNApp))))
        (check-eq?  (free-term-name 
                      (app-term-func (neutral-quote 2 anNApp))) aValueName)
        (check-true (free-term? (app-term-arg (neutral-quote 2 anNApp))))
        (check-eq?  (free-term-name 
                      (app-term-arg (neutral-quote 2 anNApp))) aValueName)

        ;; rec-quote (VNeutral)
        (check-true (free-term? (rec-quote 10 aVNeutral)))
        (check-eq?  (free-term-name (rec-quote 10 aVNeutral)) aValueName)

        (check-true (lam-term? (rec-quote 1 aVLam)))
        (check-true (bnd-term? (lam-term-term (rec-quote 1 aVLam))))
        (check-eq?  (bnd-term-index (lam-term-term (rec-quote 1 aVLam))) 0)

        ;; lp-quote
        (check-true (free-term? (lp-quote aVNeutral)))
        (check-eq?  (free-term-name (lp-quote aVNeutral)) aValueName)
      )
    )

    (test-case "Test subst proceedure"
      (let* (
        [ varStr01   "varName01" ]
        [ varName01  (global-name varStr01) ]
        [ freeTerm01 (free-term varName01) ]
        [ varStr02   "varName02" ]
        [ varName02  (global-name varStr02) ]
        [ freeTerm02 (free-term varName02) ]
        [ typeStr    "typeName" ]
        [ typeName   (global-name typeStr) ]
        [ aType      (tfree-type typeName) ]
        [ bound00    (bnd-term 0) ]
        [ bound01    (bnd-term 1) ]
        [ ann00      (ann-term bound00 aType) ]
        [ ann01      (ann-term bound01 aType) ]
        [ app00      (app-term bound00 bound00) ]
        [ app01      (app-term bound00 bound01) ]
        [ app10      (app-term bound01 bound00) ]
        [ lam00      (lam-term bound00) ]
        [ lam01      (lam-term bound01) ]
            )

        ;; free-terms do not get replaced
        (check-equal? (subst 10 freeTerm01 freeTerm02) freeTerm02)

        ;; bnd-terms get replaced depending upon anInt
        (check-equal? (subst 1 freeTerm01 bound00) bound00)
        (check-equal? (subst 1 freeTerm01 bound01) freeTerm01)

        ;; ann-terms no substitution needed
        (check-equal? (subst 1 freeTerm01 ann00) ann00)

        ;; ann-terms substitution performed
        (check-true   (ann-term? (subst 0 freeTerm01 ann00)))
        (check-true   (free-term? (ann-term-term (subst 0 freeTerm01 ann00))))

        ;; app-term no subsitution needed
        (check-equal? (subst 1 freeTerm01 app00) app00)

        ;; app-term subsitution of func performed
        (check-true   (app-term? (subst 1 freeTerm01 app10)))
        (check-true   (free-term? (app-term-func (subst 1 freeTerm01 app10))))

        ;; app-term subsitution of arg performed
        (check-true   (app-term? (subst 1 freeTerm01 app01)))
        (check-true   (free-term? (app-term-arg (subst 1 freeTerm01 app01))))

        ;; lam-term no subsitution needed
        (check-equal? (subst 1 freeTerm01 lam00) lam00)

        ;; lam-term subsitution performed
        (check-true   (lam-term? (subst 0 freeTerm01 lam01)))
        (check-true   (free-term? (lam-term-term (subst 0 freeTerm01 lam01))))
      )
    )

  )
)

(define ignore-value (run-tests all-tests 'verbose))

