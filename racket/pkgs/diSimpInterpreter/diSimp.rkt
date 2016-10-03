#lang diSimpRacketLayer

(require (prefix-in diSimp:: diSimpInterpreter/operators))
(require (submod diSimpInterpreter/operators privateAPI))

;; This form, if it works, is very restrictive
;;
(provide 
  diSimp
)

(define (updateInstructions topInstruction someInstructions someData)
  (cond
    [ (operator? topInstruction)
      (advanceInstruction someInstructions) ]
    [ (combinator? topInstruction)
      (cond 
        [ (equal? diSimp::comb::someThing)
          (diSimp::comb::doSomeThing someInstructions) ]
        [ else someInstructions ]
      )
    ]
  )
)

(define (updateData topInstruction someInstructions someData)
  (cond
    [(operator? topInstruction)
      (cond 
        [ (equal? diSimp::op::someThing)
          (diSimp::op::doSomeThing someData) ]
        [ else someData ]
      )
    ]
  )
)

(define (diSimp aComputation)
  (let* ( [ someInstructions (getInstructions aComputation) ]
          [ topInstruction   (getTop someInstructions) ]
          [ someData         (getData aComputation) ] )
    (createComputation 
      (updateInstructions topInstruction someInstructions someData)
      (updateData         topInstruction someInstructions someData)
    )
  )
)
