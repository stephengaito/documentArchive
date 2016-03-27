#lang racketLayer

(require 
  "namesData.rkt"
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
  subst
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

(define (subst anInt aNewTerm anOldTerm)
  (case (car anOldTerm)
    [ ( Ann )    (ann-term 
                   (subst anInt aNewTerm (ann-term-term anOldTerm))
                   (ann-term-type anOldTerm)
                 ) ]
    [ ( Bound )  (if (eq? anInt (bnd-term-index anOldTerm))
                   aNewTerm
                   anOldTerm
                 ) ]
    [ ( Free )   anOldTerm ]
    [ ( App )    (app-term 
                   (subst anInt aNewTerm (app-term-func anOldTerm))
                   (subst anInt aNewTerm (app-term-arg anOldTerm))
                 ) ]
    [ ( Lambda ) (lam-term 
                   (subst
                     (+ anInt 1) 
                     aNewTerm
                     (lam-term-term anOldTerm)
                   )
                 ) ]
  )
)
