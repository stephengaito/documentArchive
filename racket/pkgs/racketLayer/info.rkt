#lang info
(define collection "racketLayer")
(define deps '("base"
               "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/racketLayer.scrbl" (multi-page))))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(Stephen Gaito))
