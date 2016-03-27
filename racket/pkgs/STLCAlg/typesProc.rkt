#lang racketLayer

(require
  "namesData.rkt"
  "typesData.rkt"
  "typesCtxData.rkt"
  "termsData.rkt"
)

(provide
;  chk-kind
;  infer-type
;  infer-rec-type
;  chk-rec-type
)

;; The chk-kind proceedure either returns #t or raises an arguments error
;;
(define (chk-kind aCtx aType aKind)
  (case (car aType)
    [ ( TFree ) (let ([anInfo (get-info-ctx aCtx (tfree-type-name aType))])
                  (if (kind-info? anInfo)
                    #t
                    (raise-arguments-error
                      'not-a-kind
                      "name" (tfree-type-name aType)
                    )
                  )
                ) ]
    [ ( Func )  (and 
                  (chk-kind aCtx (func-type-domain aType) aKind)
                  (chk-kind aCtx (func-type-range  aType) aKind)
                ) ]
  )
)

;; The infer-type proceedure either returns a type or raises an arguments 
;; error
;;
(define (infer-type aCtx aType)
  (infer-rec-type 0 aCtx aType)
)

;; The infer-rec-type proceedure either returns a type or raises an 
;; arguments error
;;
(define (infer-rec-type anInt aCtx aTerm)
  (case (car aTerm)
    [ ( Ann )  (let ([ annType (ann-term-type aTerm)])
                 (begin
                   (chk-kind aCtx annType (kind))
                   (chk-rec-type anInt aCtx (ann-term-term aTerm) annType)
                   annType
                 )
               ) ]
    [ ( Free ) (let ([anInfo (get-info-ctx aCtx (free-term-name aTerm))])
                 (if (type-info? anInfo)
                   (type-info-type anInfo)
                   (raise-arguments-error
                     'not-a-type
                     "name: " (free-term-name aTerm)
                   )
                 )
               ) ]
    [ ( App )  (let ([ funcType (infer-rec-type 
                                  anInt 
                                  aCtx
                                  (app-term-func aTerm)
                                ) ])
                 (if (func-type? funcType)
                   (begin 
                     (chk-rec-type 
                       anInt 
                       aCtx 
                       (app-term-arg aTerm)
                       (func-type-domain funcType)
                     )
                     (func-type-range funcType)
                   )
                   (raise-arguments-error
                     'illegal-application
                     "rangeType: " (pretty-print funcType)
                     " argument: " (pretty-print (app-term-arg aTerm))
                   )
                 )
               ) ]
  )
)


(define (chk-rec-type anInt aCtx aTerm aType)
  (if (lam-term? aTerm)
    (if (func-type? aType)
      (chk-rec-type 
        (+ 1 anInt)
        (extend-ctx (local-name anInt) (type-info (func-type-domain aType)) aCtx)
        (func-type-range aType)
      )
      (raise-arguments-error
        'not-func-type
        "type: " (pretty-print aType)
      )
    )
    (let ([ inferedType (infer-rec-type anInt aCtx aTerm) ])
      (if (equal? inferedType aType)
        #t
        (raise-arguments-error
          'type-mismatch
          " inferedType: " (pretty-print inferedType)
          "requiredType: " (pretty-print aType)
        )
      )
    )
  )
)

