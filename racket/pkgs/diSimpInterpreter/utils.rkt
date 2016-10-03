#lang diSimpRacketLayer

(module+ privateAPI
  (provide 
    diSimpTag
    nextStep
    previousStep
    pushContext
    popContext
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

;; A biStream is a tree which represents a bi-infinite list of lists.
;;
;; The tree representing a given biStream MUST have at least three
;; subtrees with the structure: ( contextTree . ( pastTree . futureTree ))
;;
;; The following functions map biStreams to biStreams, allowing us to 
;; "move" around a given biStream/tree
;;

;; The nextStep biStream moves the current structure one subTree into 
;; the future.
;;
;; (nextStep (previousStep aBiStream)) == aBiStream
;;
(define (nextStep aBiStream)
  (let ([ contextTree (car aBiStream) ]
        [ pastTree    (cadr aBiStream) ]
        [ futureTree  (cddr aBiStream) ])
    (cons
      contextTree
      (cons 
        (cons (car futureTree) pastTree)
        (cdr futureTree)
      )
    )
  )
)

;; The previousStep biStream moves the current structure one subTree into 
;; the past.
;;
;; (previousStep (nextStep aBiStream)) == aBiStream
;;
(define (previousStep aBiStream)
  (let ([ contextTree (car aBiStream) ]
        [ pastTree    (cadr aBiStream) ]
        [ futureTree  (cddr aBiStream) ])
    (cons
      contextTree
      (cons 
        (cdr pastTree)
        (cons (car pastTree) futureTree)
      )
    )
  )
)

;; The pushContext biStream function moves the current structure into the 
;; current structure's subTree.
;;
;; (pushContext (popContext aBiStream)) == aBiStream
;;
(define (pushContext aBiStream)
  (let ([ contextTree (car aBiStream) ]
        [ pastTree    (cadr aBiStream) ]
        [ futureTree  (cddr aBiStream) ])
    (cons 
      (cons 
        (cons pastTree futureTree)
        contextTree
      )
      (cons 
        '()
        (car futureTree)
      )
    )
  )
)

;; The popContext biStream function move the current structure out of the 
;; current structure's subTee.
;;
;; (popContext (pushContext aBiStream)) == aBiStream
;;
(define (popContext aBiStream)
  (let ([ contextTree (car aBiStream) ]
        [ pastTree    (cadr aBiStream) ]
        [ futureTree  (cddr aBiStream) ])
    (cons
      (cdr contextTree)
      (car contextTree)
    )
  )
)
