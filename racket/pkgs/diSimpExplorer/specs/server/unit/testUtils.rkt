#lang racket

;; Goal: To ensure the test-utils.rkt functions preform correctly.

(require
  rackunit
  rackunit/text-ui
)

(require diSimpExplorer/specs/server/test-utils)

(define all-tests
  (test-suite "Test-utils"

    ;; The begin-equal? predicate checks to see if the
    ;; pattern is a "subset" of the xexpr.
    ;;
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

    ;; The select predicate selects all elements of the xexpr
    ;; which begin with the pattern.
    ;;
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
