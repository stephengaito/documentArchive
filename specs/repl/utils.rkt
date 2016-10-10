#lang racket

(require racket/os)

(provide
  addSpec
  runSpecsOn
)

(define specList '() )
(define resultList '() )

(define (addSpec comment spec expected)
  (set! specList (cons (list comment spec expected) specList))
)

(define (read-until-next-prompt observedResults resultFile)
  (let ( [ peekResult (peek-string 2 0 resultFile) ] )
    (if (string=? peekResult "->")
      (begin
        (read-string 3 resultFile)
        observedResults
      )
      (let ( [ aLine (read-line resultFile) ] )
        (read-until-next-prompt (cons aLine observedResults) resultFile)
      )
    )
  )
)

(define (check-result-lines expectedRegExps observedResults resultFile)
  (let ( [ peekResult (peek-string 2 0 resultFile) ] )
    (if (string=? peekResult "->")
      (begin
        (read-string 3 resultFile)
        '()
      )
      (let ( [ aLine (read-line resultFile) ] )
        (if (null? expectedRegExps)
          '()
          ;(if (regexp-match (car expectedRegExps) aLine)
          (if (string=? (car expectedRegExps) aLine)
            (check-result-lines
              (cdr expectedRegExps)
              (cons aLine observedResults)
              resultFile
            )
            (read-until-next-prompt (cons aLine observedResults) resultFile)
          )
        )
      )
    )
  )
)

(define (check-result comment expectedRegExps resultFile)
  (let ( [ theResult (check-result-lines expectedRegExps '() resultFile) ] )
    (if (null? theResult)
      (displayln (string-append "SUCCESS: " comment))
      (begin
        (displayln (string-append "\nFAILED: " comment))
        (displayln "expected:")
        (for ( [ aRegExp (in-list expectedRegExps) ] )
          (displayln (string-append "\t" aRegExp))
        )
        (displayln "found:")
        (for ( [ aResult (in-list theResult) ] )
          (displayln (string-append "\t" aResult))
        )
      )
    )
  )
)

(define baseFileName (string-append "/tmp/rJoySpec-" (~a (getpid))))
(define specFileName (string-append baseFileName ".spec"))
(define resultsFileName (string-append baseFileName ".results"))

(define (runSpecsOn specCommand)
  (set! specList (reverse specList))

  (define specFile (open-output-file specFileName))
  (for ( [ aSpec (in-list specList) ] )
    (displayln (cadr aSpec) specFile)
  )
  (close-output-port specFile)

  (system (string-append "./rJoy < " specFileName " > " resultsFileName))

  (define resultsFile (open-input-file resultsFileName))
  (read-until-next-prompt '() resultsFile)
  (newline)

  (for ( [ aSpec (in-list specList) ] )
    (let ( [ aComment (car aSpec) ]
           [ someExpectedRegExps (caddr aSpec) ] )
      (check-result aComment someExpectedRegExps resultsFile)
    )
  )

  (newline)
  (for ( [ line (in-lines resultsFile) ] )
    (displayln line)
  )

  (void (system (string-append "rm " specFileName " " resultsFileName)))
)


