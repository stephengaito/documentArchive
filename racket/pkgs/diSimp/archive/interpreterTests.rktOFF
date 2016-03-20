#lang racket/base

(require rackunit)
(require rackunit/text-ui)

(require "../interpreter.rkt")
(require "../listExps.rkt")

(define verbose-mode (make-parameter #f))

(define all-tests
  (test-suite  "Interpreter"

    (test-case "Test intrepretation of list expressions"
      (let* ([ null-lst (null-list-exp) ]
             [ cons-lst (cons-list-exp null-lst null-lst) ]
             [ car-lst  (car-list-exp cons-lst) ]
             [ bad-car  (car-list-exp null-lst) ]
             [ cdr-lst  (cdr-list-exp cons-lst) ]
             [ bad-cdr  (cdr-list-exp null-lst) ]
            )
        (check equal? '()
          (interpret verbose-mode null-lst))
        (check equal? '( () () )
          (interpret verbose-mode cons-lst))
        (check equal? '()
          (interpret verbose-mode car-lst))
        (check-exn exn:fail:user?
          (lambda () (interpret verbose-mode bad-car)))
        ;;
        ;; vvvv IS THIS CORRECT?!! vvvv
        (check equal? '(())
          (interpret verbose-mode cdr-lst))
        ;; ^^^^ IS THIS CORRECT?!! ^^^^
        ;;
        (check-exn exn:fail:user?
          (lambda () (interpret verbose-mode bad-cdr)))
        (check-exn exn:fail:user? 
          (lambda () (interpret verbose-mode '(silly sillier))))
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
