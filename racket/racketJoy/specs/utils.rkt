#lang racket

(require
  rackunit
  rackunit/text-ui
)

(provide run-test-suites )

(define (run-test-suites test-suites)
  (void 
    (map
      (lambda (aTestSuite)
        (newline)
        (displayln (rackunit-test-suite-name aTestSuite))
        (run-tests aTestSuite 'verbose)
      )
      test-suites
    )
  )
)
