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

