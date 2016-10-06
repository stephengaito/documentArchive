#lang at-exp racket/base

(require scribble/eval
         scribble/manual)

(provide author-stg)

(define (author-stg)
  @author{@(author+email "PerceptiSys Ltd (Stephen Gaito)" "stephen@perceptisys.co.uk")})

