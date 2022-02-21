#lang lp4RacketLayer

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
  vneutral-value?
  vneutral-value
  vneutral-value-neutral
  env?
  empty-env?
  empty-env
  extend-env?
  extend-env
  extend-env-value
  get-index-env
)

(define (neutral? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (case (car someThing)
      [ (NFree NApp) #t ]
      [ else #f ]
    )
  )
)

(define (nfree-neutral? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
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
    (< 0 (length someThing))
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
    (< 0 (length someThing))
    (case (car someThing)
      [ (VLam VNeutral) #t ]
      [ else #f ]
    )
  )
)

(define (vlam-value? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'VLam)
  )
)

(define (vlam-value aLambdaFunc)
  (list 'VLam aLambdaFunc)
)

(define (vlam-value-func aVLamValue)
  (cadr aVLamValue)
)

(define (vneutral-value? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'VNeutral)
  )
)

(define (vneutral-value aNeutral)
  (list 'VNeutral aNeutral)
)

(define (vneutral-value-neutral aVNeutralValue)
  (cadr aVNeutralValue)
)

(define (env? someThing)
  (and (list? someThing)
    (< 0 (length someThing))
    (eq? (car someThing) 'Env)
  )
)

(define (empty-env? someThing)
  (and (list? someThing)
    (eq? (length someThing) 1)
    (eq? (car someThing) 'Env)
  )
)

(define (empty-env)
  (list 'Env)
)

(define (extend-env? someThing)
  (and (list? someThing)
    (< 1 (length someThing))
    (eq? (car someThing) 'Env)
  )
)

(define (extend-env aValue anEnv)
  (list* 'Env aValue (cdr anEnv))
)

(define (extend-env-value anEnv)
  (cadr anEnv)
)

(define (get-index-env anInt anEnv)
  (car (list-tail anEnv (+ anInt 1)))
)
