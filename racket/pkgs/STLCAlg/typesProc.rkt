#lang racketLayer

(require racketLayer/exceptions)

(require
  "namesData.rkt"
  "typesData.rkt"
  "typesCtxData.rkt"
  "termsData.rkt"
  "termsProc.rkt"
)

(provide
  exn-not-a-kind?
  chk-kind
  exn-not-a-type?
  exn-illegal-application?
  infer-type
  infer-rec-type
  exn-not-func-type?
  exn-type-mismatch?
  chk-rec-type
)

(define (exn-not-a-kind? anExn)
  (and (exn:fail:contract? anExn)
    (regexp-match #rx"^not-a-kind" (exn-message anExn))
  )
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
                      "The object named is not a kind"
                      "name" (pretty-format (tfree-type-name aType) #:mode 'display)
                      "info" (pretty-format anInfo #:mode 'display)
                    )
                  )
                ) ]
    [ ( Func )  (and 
                  (chk-kind aCtx (func-type-domain aType) aKind)
                  (chk-kind aCtx (func-type-range  aType) aKind)
                ) ]
  )
)

(define (exn-not-a-type? anExn)
  (and (exn:fail:contract? anExn)
    (regexp-match #rx"^not-a-type" (exn-message anExn))
  )
)

(define (exn-illegal-application? anExn)
  (and (exn:fail:contract? anExn)
    (regexp-match #rx"^illegal-application" (exn-message anExn))
  )
)

;; The infer-type proceedure either returns a type or raises an arguments 
;; error
;;
(define (infer-type aCtx aTerm)
  (infer-rec-type 0 aCtx aTerm)
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
                     "The object named is not a type"
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
                     "The type of the argument is incorrect for the given function"
                     "rangeType: " (pretty-format funcType)
                     " argument: " (pretty-format (app-term-arg aTerm))
                   )
                 )
               ) ]
  )
)

(define (exn-not-func-type? anExn)
  (and (exn:fail:contract? anExn)
    (regexp-match #rx"^not-func-type" (exn-message anExn))
  )
)

(define (exn-type-mismatch? anExn)
  (and (exn:fail:contract? anExn)
    (regexp-match #rx"^type-mismatch" (exn-message anExn))
  )
)

(define (chk-rec-type anInt aCtx aTerm aType)
  (if (lam-term? aTerm)
    (if (func-type? aType)
      (chk-rec-type 
        (+ 1 anInt)
        (extend-ctx (local-name anInt) (type-info (func-type-domain aType)) aCtx)
        (subst 0 (free-term (local-name anInt)) (lam-term-term aTerm))
        (func-type-range aType)
      )
      (raise-arguments-error
        'not-func-type
        "Recursively checking that a given term is a given type"
        "type: " (pretty-format aType)
      )
    )
    (let ([ inferedType (infer-rec-type anInt aCtx aTerm) ])
      (if (equal? inferedType aType)
        #t
        (raise-arguments-error
          'type-mismatch
          "The type of the given term is not the same as the given type"
          " inferedType: " (pretty-format inferedType)
          "requiredType: " (pretty-format aType)
        )
      )
    )
  )
)

