#lang racket

;; Goal: Browse avaliable Languages

;; Story: A user starts the diSimpExplorer and is presetned with the 
;; current list of languages

(require 
  rackunit
  rackunit/text-ui
)

(require
  diSimpExplorer/server/restfulServlets
  diSimpExplorer/server/dseFramework
  diSimpExplorer/specs/server/test-utils
)

(define all-tests
  (test-suite "Browse available languages"
    (test-case "There should be some languages"
      (define theRequest (build-request #"GET" "/"))
      (check-equal? (url->string (request-uri theRequest)) "/")
      (check-equal? (request-method theRequest) #"GET")

      (define aResponse (request->handler theRequest default-response-maker))
      (check-equal? (response-code aResponse) 200)
      (define body (response-body aResponse))
      ;;(displayln body)
      (define selection (select '(div ((class "language"))) body))
      ;;(displayln selection)
      (check-true (list? selection))
      (check-equal? (length selection) 3)
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
