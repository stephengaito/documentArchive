#lang racketLayer

(provide
  neutral?
  nfree-neutral?
  nfree-neutral
  nfree-neutral-name
  napp-neutral?
  napp-neutral
  napp-neutral-func
  napp-neutral-arg
  value?
  vlam-value?
  vlam-value
  vlam-value-func
  vlam-value-arg
  vneutral-value?
  vneutral-value
  vneutral-value-neutral
)

(define (neutral? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ (NFree NApp) #t ]
      [ else #f ]
    )
  )
)

(define (nfree-neutral? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'NFree)
  )
)

(define (nfree-neutral aName)
  (list 'NFree aName)
)

(define (nfree-neutral-name anNFreeNeutral)
  (cadr anNFreeNeutral)
)

(define (napp-neutral? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'NApp)
  )
)

(define (napp-neutral aFuncNeutral anArgValue)
  (list 'NApp aFuncNeutral anArgValue)
)

(define (napp-neutral-func anNAppNeutral)
  (cadr anNAppNeutral)
)

(define (napp-neutral-arg anNAppNeutral)
  (caddr anNAppNeutral)
)

(define (value? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ (VLam VNeutral) #t ]
      [ else #f ]
    )
  )
)

(define (vlam-value? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'VLam)
  )
)

(define (vlam-value aFuncValue anArgValue)
  (list 'VLam aFuncValue anArgValue)
)

(define (vlam-value-func aVLamValue)
  (cadr aVLamValue)
)

(define (vlam-value-arg aVLamValue)
  (caddr aVLamValue)
)

(define (vneutral-value? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'VNeutral)
  )
)

(define (vneutral-value aNeutral)
  (list 'VNeutral aNeutral)
)

(define (vneutral-value-neutral aVNeutralValue)
  (cadr aVNeutralValue)
)
