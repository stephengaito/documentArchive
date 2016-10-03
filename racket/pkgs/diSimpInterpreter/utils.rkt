#lang diSimpRacketLayer

(module+ privateAPI
  (provide 
    diSimpTag
    getContextStack
    getPastStack
    getFutureStack
    getTop
    createBiStream
    pushTree
    popTree
    nextStep
    previousStep
    pushContext
    popContext
    getInstructions
    getData
    createComputation
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

(define (getTop aBiStream)
  (car (getFutureStack aBiStream))
)

(define (createBiStream aContextStack aPastStack aFutureStack)
  (cons aContextStack (cons aPastStack aFutureStack))
)

;; Push a tree onto the current top of the biStream
;;
(define (pushTree aTree aBiStream)
  (createBiStream 
    (getContextStack aBiStream)
    (getPastStack aBiStream)
    (cons aTree (getFutureStack aBiStream))
  )
)

;; Pop the tree off the current top of the biStream
;;
(define (popTree aBiStream)
  (createBiStream
    (getContextStack aBiStream)
    (getPastStack aBiStream)
    (cdr (getFutureStack aBiStream))
  )
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
    (createBiStream
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
    (createBiStream
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
    (createBiStream
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

;; A computation is a pair of ( instructionBiStream . dataBiStream)
;;

(define (getInstructions aComputation)
  (car aComputation)
)

(define (getData aComputation)
  (cdr aComputation)
)

(define (createComputation someInstructions someData)
  (cons someInstructions someData)
)


