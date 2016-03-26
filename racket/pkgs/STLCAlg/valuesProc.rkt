#lang racketLayer

(require
  "valuesData.rkt"
  "termsData.rkt"
)

(provide
  value-free
  value-app
  eval
)

(define (value-free aName)
  (list (vneutral-value (nfree-neutral aName)))
)

(define (value-app aFuncValue anArgValue)
  (case (car aFuncValue)
    [ ( VLam )    ((vlam-value-func aFuncValue) anArgValue) ]
;    [ ( VNeutral) (vlam-value 
;                    (lambda (x)
;                      (eval (lam-term (lam-term-term aFuncValue) ???))
;                    )
;                  ) ]
    [ else null ]
  )
)

(define (eval anInfTerm anEnv)
  (case (car anInfTerm) 
    [ ( Ann )    (eval (ann-term-term anInfTerm) anEnv) ]
    [ ( Free )   (value-free (free-term-name anInfTerm) ) ]
    ;;[ ( Bound ) (??) ]
    [ ( App )    (value-app 
                   (eval (app-term-func anInfTerm) anEnv) 
                   (eval (app-term-arg  anInfTerm) anEnv)
                 ) ]
    ;;[ ( Lambda ) (???) ]
    [ else null ]
  )
)
