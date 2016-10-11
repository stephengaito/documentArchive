#lang racket

(require "utils.rkt")

(addSpec "Simple stack"
  '(+ 1 1)
  (list "((+ 1 1))")
)

(addSpec "deeper stack"
  '(+ 2 2 ) 
  (list "((+ 2 2) (+ 1 1))")
)

(runSpecsOn "rJoy")
