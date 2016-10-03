#lang diSimpRacketLayer

(module+ privateAPI
  (provide 
    diSimpTag
    nextStep
    previousStep
    pushContext
    popContext
    getContextStack
    getPastStack
    getFutureStack
    createBiStack
  )
)

;; creates a diSimp::tag of the appropriate value
;;
(define (diSimpTag aValue) 
  (if (positive? aValue)
    (list (diSimpTag (- aValue 1)))
    '()
  )
)

;; A biStream is a stack which represents a bi-infinite list of lists.
;;
;; The stack representing a given biStream MUST have at least three
;; subStacks with the structure: ( contextStack . ( pastStack . futureStack ))
;;
;; The following functions map biStreams to biStreams, allowing us to 
;; "move" around a given biStream/stack
;;

(define (getContextStack aBiStream)
  (car aBiStream)
)

(define (getPastStack aBiStream)
  (cadr aBiStream)
)

(define (getFutureStack aBiStream)
  (cddr aBiStream)
)

(define (createBiStack aContextStack aPastStack aFutureStack)
  (cons aContextStack (cons aPastStack aFutureStack))
)

;; The nextStep biStream moves the current structure one subStack into 
;; the future.
;;
;; (nextStep (previousStep aBiStream)) == aBiStream
;;
(define (nextStep aBiStream)
  (let ([ contextStack (getContextStack aBiStream) ]
        [ pastStack    (getPastStack    aBiStream) ]
        [ futureStack  (getFutureStack  aBiStream) ])
    (createBiStack
      contextStack
      (cons (car futureStack) pastStack)
      (cdr futureStack)
    )
  )
)

;; The previousStep biStream moves the current structure one subStack into 
;; the past.
;;
;; (previousStep (nextStep aBiStream)) == aBiStream
;;
(define (previousStep aBiStream)
  (let ([ contextStack (getContextStack aBiStream) ]
        [ pastStack    (getPastStack    aBiStream) ]
        [ futureStack  (getFutureStack  aBiStream) ])
    (createBiStack
      contextStack
      (cdr pastStack)
      (cons (car pastStack) futureStack)
    )
  )
)

;; The pushContext biStream function moves the current structure into the 
;; current structure's subStack.
;;
;; (pushContext (popContext aBiStream)) == aBiStream
;;
(define (pushContext aBiStream)
  (let ([ contextStack (getContextStack aBiStream) ]
        [ pastStack    (getPastStack    aBiStream) ]
        [ futureStack  (getFutureStack  aBiStream) ])
    (createBiStack
      (cons 
        (cons pastStack futureStack)
        contextStack
      )
     '()
      (car futureStack)
    )
  )
)

;; The popContext biStream function move the current structure out of the 
;; current structure's subTee.
;;
;; (popContext (pushContext aBiStream)) == aBiStream
;;
(define (popContext aBiStream)
  (let ([ contextStack (getContextStack aBiStream) ]
        [ pastStack    (getPastStack    aBiStream) ]
        [ futureStack  (getFutureStack  aBiStream) ])
    (cons
      (cdr contextStack)
      (car contextStack)
    )
  )
)
