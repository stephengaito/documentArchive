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
  (test-suite  "Term Procs (lp-quote rec-quote neutral-quote bound-free)"

    (test-case "Test quote proceedure"
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

  )
)

(define ignore-value (run-tests all-tests 'verbose))

