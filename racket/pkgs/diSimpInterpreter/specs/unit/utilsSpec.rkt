#lang racket

;; Goal: show that diSimp is a function from lists to lists

;; Story: anything will do

(require 
  rackunit
  rackunit/text-ui
)

(require
  diSimpInterpreter
  (submod diSimpInterpreter/utils privateAPI)
)

(define all-tests
  (begin 

    (test-suite "Test utils/privateAPI"
      (test-case "diSimpTag counts correctly"
        (check-equal? (diSimpTag 0) '() )
        (check-equal? (diSimpTag 1) '(()) )
        (check-equal? (diSimpTag 2) '((())) )
        (check-equal? (diSimpTag 3) '(((()))) )
      )

      (test-case "biStream nextStep moves into the future"
        (let ([ aBiStream '(() () 1 2 3 4 5) ])
          (check-equal? (nextStep aBiStream) '(() (1) 2 3 4 5) )
          (check-equal? (nextStep (nextStep aBiStream)) '(() (2 1)  3 4 5))
          (check-equal? 
            (nextStep (nextStep (nextStep aBiStream))) 
            '(() (3 2 1) 4 5)
          )
        )
      )

      (test-case "biStream previousStep moves into the past"
        (let ([ aBiStream '(() (5 4 3 2 1) ) ])
          (check-equal? (previousStep aBiStream) '(() (4 3 2 1) 5) )
          (check-equal? 
            (previousStep (previousStep aBiStream)) 
            '(() (3 2 1)  4 5)
          )
          (check-equal? 
            (previousStep (previousStep (previousStep aBiStream))) 
            '(() (2 1) 3 4 5)
          )
        )
      )

      (test-case "biStream nextStep/previousStep invariants"
        (let ([ aBiStream '(() (3 2 1) 4 5) ])
          (check-equal? (nextStep (previousStep aBiStream)) aBiStream )
          (check-equal? (previousStep (nextStep aBiStream)) aBiStream )
        )
      )

      (test-case "biStream pushContext moves into the current subTree"
        (let ([ aBiStream '(() (3 2 1) ((4 5) 6) 7) ])
          (check-equal? 
            (pushContext aBiStream) 
            '((((3 2 1) ((4 5) 6) 7)) () (4 5) 6)
          )
        )
      )

      (test-case "biStream popContext moves out of the current subTree"
        (let ([ aBiStream '((((3 2 1) ((4 5) 6) 7)) () (4 5) 6) ])
          (check-equal? (popContext aBiStream) '(() (3 2 1) ((4 5) 6) 7) )
        )
      )

      (test-case "biStream pushContext/popContext invariants"
        (let ([ aBiStream '((((3 2 1) ((4 5) 6) 7)) () (4 5) 6) ])
          (check-equal? (popContext (pushContext aBiStream)) aBiStream)
          (check-equal? (pushContext (popContext aBiStream)) aBiStream)
        )
      )

    )
  )
)

(define ingnore-value (run-tests all-tests 'verbose))
