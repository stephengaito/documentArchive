#lang racket

(require
  rackunit
  rackunit/text-ui
)

(require diSimpExplorer/specs/server/test-utils)

;; Some unit tests of the test-utlis.rkt functions

(define all-tests
  (test-suite "Test-utils"
    (test-case "begin-equal?"
      (check-true (begin-equal? '(div) '(div silly)))
      (check-true 
        (begin-equal? 
          '(div ((class languages)))
          '(div ((class languages))
            (div ((class language)) sillier) 
            (div ((class language)) silliest) 
            (div ((class language)) silly) 
          )
        )
      )
    )

    (test-case "select"
      (define selection
        (select
          '(div ((class language)))
          '(div ((class languages))
            (div ((class language)) sillier) 
            (div ((class language)) silliest) 
            (div ((class language)) silly) 
          )
        )
      )
      (check-true (list? selection))
      (check-equal? (length selection) 3)
    )
  )
) 

(define ignore-value (run-tests all-tests 'verbose))
