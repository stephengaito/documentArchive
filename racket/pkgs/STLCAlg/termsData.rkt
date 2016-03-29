#lang racketLayer

(provide
  term?
  inf-term?
  chk-term?
  bnd-term?
  bnd-term
  bnd-term-index
  ann-term?
  ann-term
  ann-term-term
  ann-term-type
  free-term?
  free-term
  free-term-name
  app-term?
  app-term
  app-term-func
  app-term-arg
  lam-term?
  lam-term
  lam-term-term
)

(define (term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (case (car someThing)
      [ ( Bound Ann Free App Lambda) #t ]
      [ else #f ]
    )
  )
)

(define (inf-term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (case (car someThing)
      [ ( Bound Ann Free App) #t ]
      [ else #f ]
    )
  )
)

(define (chk-term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (case (car someThing)
      [ ( Lambda ) #t ]
      [ else #f ]
    )
  )
)

(define (bnd-term? someThing)
  (and (list? someThing) 
    (< 0 (length someThing))
    (eq? (car someThing) 'Bound)
  )
)

(define (bnd-term aBindingNum)
  (list 'Bound aBindingNum)
)

(define (bnd-term-index aBndTerm)
  (cadr aBndTerm)
)

(define (ann-term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'Ann)
  )
)

(define (ann-term aTerm aType)
  (list 'Ann aTerm aType)
)

(define (ann-term-term anAnnotation)
  (cadr anAnnotation)
)

(define (ann-term-type anAnnotation)
  (caddr anAnnotation)
)

(define (free-term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'Free)
  )
)

(define (free-term aVarName)
  (list 'Free aVarName)
)

(define (free-term-name aFreeTerm)
  (cadr aFreeTerm)
)

(define (app-term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'App)
  )
)

(define (app-term aFunctionTerm anArgumentTerm)
  (list 'App aFunctionTerm anArgumentTerm)
)

(define (app-term-func anApplication)
  (cadr anApplication)
)

(define (app-term-arg anApplication)
  (caddr anApplication)
)

(define (lam-term? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'Lambda)
  )
)

(define (lam-term aTerm)
  (list 'Lambda aTerm)
)

(define (lam-term-term aLambdaTerm)
  (cadr aLambdaTerm)
)
