#lang lp4RacketLayer

(require
  "valuesData.rkt"
  "termsData.rkt"
)

(provide
  value-free
  value-app
  lp-eval
)

(define (value-free aName)
  (vneutral-value (nfree-neutral aName))
)

(define (value-app aFuncValue anArgValue)
  (case (car aFuncValue)
    [ ( VLam )    ((vlam-value-func aFuncValue) anArgValue) ]
    [ ( VNeutral) (vneutral-value
                    (napp-neutral
                      (vneutral-value-neutral aFuncValue)
                      anArgValue
                    )
                  ) ]
    [ else null ]
  )
)

(define (lp-eval aTerm anEnv)
  (case (car aTerm) 
    [ ( Ann )    (lp-eval (ann-term-term aTerm) anEnv) ]
    [ ( Free )   (value-free (free-term-name aTerm) ) ]
    [ ( Bound )  (get-index-env (bnd-term-index aTerm) anEnv) ]
    [ ( App )    (value-app 
                   (lp-eval (app-term-func aTerm) anEnv) 
                   (lp-eval (app-term-arg  aTerm) anEnv)
                 ) ]
    [ ( Lambda ) (vlam-value
                   (lambda (x)
                     (lp-eval (lam-term-term aTerm) (extend-env x anEnv))
                   )
                 ) ]
    [ else null ]
  )
)
