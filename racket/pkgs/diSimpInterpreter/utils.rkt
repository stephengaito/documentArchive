#lang diSimpRacketLayer

(module+ privateAPI
  (provide diSimpTag)
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
;; The tree representing a given biStream MUST have at least two 
;; subtrees with the structure: ( pastTree . futureTree )
;;
;; The following functions map biStreams to biStreams, allowing us to 
;; "move" around a given biStream/tree
;;

;; The next biStream moves the current structure one subTree into 
;; the future.
;;
;; (next (previous aBiStream)) == aBiStream
;;
(define (next aBiStream)
  (let ([ pastTree   (car aBiStream) ]
        [ futureTree (cdr aBiStream) ])
    (cons (cons (car futureTree) pastTree) (cdr futureTree))
  )
)

;; The previous biStream moves the current structure one subTree into 
;; the past.
;;
;; (previous (next aBiStream)) == aBiStream
;;
(define (previous aBiStream)
  (let ([ pastTree   (car aBiStream) ]
        [ futureTree (cdr aBiStream) ])
    (cons (cdr pastTree) (cons (car pastTree) futureTree))
  )
)

;; The into biStream function moves the current structure into the 
;; current structure's subTree.
;;
;; (into (outof aBiStream)) == aBiStream
;;
(define (into aBiStream)
  (let ([ pastTree   (car aBiStream) ]
        [ futureTree (cdr aBiStream) ])

)

;; The outof biStream function move the current structure out of the 
;; current structure's subTee.
;;
;; (outof (into aBiStream)) == aBiStream
;;
(define (outof aBiStream)
  (let ([ pastTree   (car aBiStream) ]
        [ futureTree (cdr aBiStream) ])

)
