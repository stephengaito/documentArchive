#lang racket/base

(provide interpret)

(require racket/pretty)

(define (interpret verbose-mode sExp)
  (when (verbose-mode)
    (unless (eof-object? sExp)
      (pretty-write sExp)
    )
    (printf "\n")
  )
  sExp
)
