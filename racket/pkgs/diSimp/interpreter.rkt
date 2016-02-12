#lang racket/base

(provide interpret)

(require racket/pretty)

(require diSimp/listExps)

(define (interpreter-error sExp message)
  (let ([errorStr (open-output-string)])
    (fprintf errorStr "interpret error: ~a\n" message)
    (pretty-write sExp errorStr)
    (raise-user-error (get-output-string errorStr))
  )
)

(define (interpret verbose-mode sExp)
  (when (verbose-mode)
    (unless (eof-object? sExp)
      (pretty-write sExp)
    )
    (printf "\n")
  )
  (case (car sExp)
    [ (null) '() ]
    [ (cons) (list (interpret verbose-mode (cons-exp-car sExp))
                   (interpret verbose-mode (cons-exp-cdr sExp)))]
    [ (car)  (let ([ bigStep (interpret verbose-mode (car-exp sExp))])
               (unless (pair? bigStep)
                 (interpreter-error sExp
                   "expected a pair while interpreting a car expression")
               )
               (car bigStep)
             )]
    [ (cdr)  (let ([ bigStep (interpret verbose-mode (cdr-exp sExp))])
               (unless (pair? bigStep)
                 (interpreter-error sExp
                   "expected a pair while interpreting a cdr expression")
               )
               (cdr bigStep)
             )]
    ;;
    ;; in ALL other cases throw an exn:fail:user exception
    ;;
    [ else (interpreter-error sExp
             (format "did not recognise [~a] in:\n" (car sExp)))]
  )
)
