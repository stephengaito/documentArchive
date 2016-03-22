#lang racketLayer

(provide
  kind?
  kind
  info?
  kind-info?
  kind-info
  kind-info-kind
  type-info?
  type-info
  type-info-type
  env?
  empty-env?
  empty-env
  extend-env?
  extend-env
  extend-env-name
  extend-env-info
  extend-env-next
  get-info-env
)

(define (kind? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'Star)
  )
)

(define (kind)
  (list 'Star)
)

(define (info? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ ( IKind IType ) #t ]
      [ else #f ]
    )
  )
)

(define (kind-info? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'IKind)
  )
)

(define (kind-info aKind)
  (list 'IKind aKind)
)

(define (kind-info-kind aKindInfo)
  (cadr aKindInfo)
)

(define (type-info? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'IType)
  )
)

(define (type-info aType)
  (list 'IType aType)
)

(define (type-info-type aTypeInfo)
  (cadr aTypeInfo)
)

(define (env? someThing)
  (and (list? someThing)
    (case (car someThing)
      [ ( EmptyEnv ExtendEnv ) #t ]
      [ else #f ]
    )
  )
)

(define (empty-env? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'EmptyEnv)
  )
)

(define (empty-env)
  (list 'EmptyEnv)
)

(define (extend-env? someThing)
  (and (list? someThing)
    (eq? (car someThing) 'ExtendEnv)
  )
)

(define (extend-env aName someInfo nextEnv)
  (list 'ExtendEnv aName someInfo nextEnv)
)

(define (extend-env-name anEnv)
  (cadr anEnv)
)

(define (extend-env-info anEnv)
  (caddr anEnv)
)

(define (extend-env-next anEnv)
  (cadddr anEnv)
)

(define (get-info-env anEnv aName)
  (if (list? anEnv)
    (case (car anEnv)
      [ ( ExtendEnv )
        (if (equal? (extend-env-name anEnv) aName)
          (extend-env-info anEnv)
          (get-info-env (extend-env-next anEnv) aName)
        )
      ] [ else null
      ]
    )
    null
  )
)
