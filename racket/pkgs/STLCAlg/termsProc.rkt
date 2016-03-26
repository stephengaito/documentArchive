#lang racketLayer

(require 
  "valuesData.rkt"
  "valuesProc.rkt"
  "termsData.rkt"
  "typesData.rkt"
)

(provide
  lp-quote
  rec-quote
  neutral-quote 
  bound-free
)

(define (lp-quote aValue)
  (rec-quote 0 aValue)
)

(define (rec-quote anInt aValue)
  (case (car aValue)
    [ ( VLam ) (lam-term 
                 (rec-quote 
                   (+ anInt 1) 
                   ((vlam-value-func aValue) (value-free (quote-name anInt)))
                 )
               ) ]
    [ ( VNeutral ) (neutral-quote anInt (vneutral-value-neutral aValue)) ]
  )
)

(define (neutral-quote anInt aNeutral)
  (case (car aNeutral)
    [ ( NFree ) (bound-free anInt (nfree-neutral-name aNeutral)) ]
    [ ( NApp )  (app-term 
                  (neutral-quote anInt (napp-neutral-func aNeutral))
                  (rec-quote anInt (napp-neutral-arg aNeutral))
                ) ]
  )
)

(define (bound-free anInt aName)
  (if (quote-name? aName)
    (bnd-term (- (- anInt (quote-name-index aName)) 1))
    (free-term aName)
  )
)
