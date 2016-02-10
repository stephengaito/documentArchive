#lang racket/base

(provide interpret)

(define (interpret sExp)
  (unless (eof-object? sExp)
    (print sExp)
  )
  (printf "\n")
  sExp
)

;(let ([fileName (file-to-interpret)])
;  (let ([in (open-input-file fileName)])
;    (begin
;      (printf "diSimplex Engine in Racket, version 0.0.0\n")
;      (printf "reading [~a]\n" fileName)
;      (interpret (read in))
;      (printf "\n")
;      (close-input-port in)
;      )))


