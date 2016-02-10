#!/usr/local/racket/6.3/bin/racket
#lang racket/base

(require racket/cmdline)

(define verbose-mode (make-parameter #f))

(define file-to-interpret
  (command-line
   #:program "diSimplex"
   #:once-each
   [("-v" "--verbose") "Compile with verbose messages"
                       (verbose-mode #t)]
   [("-c" "--curDir") cwd "Set the current working directory"
                      (current-directory cwd)]
   #:args (filename) ; expect one command-line argument: <filename>
   ; return the argument as a filename to compile
   filename))

(define fileName (file-to-interpret))

(require diSimp)

;(let ([in (open-input-file fileName)])
;  (begin
;    (printf "diSimplex Engine in Racket, version 0.0.0\n")
;    (printf "reading [~a]\n" fileName)
;    (interpret (read in))
;    (printf "\n")
;    (close-input-port in)
;    ))
