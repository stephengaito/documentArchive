#lang racket/base

(require rackunit)
(require rackunit/text-ui)
(require doc-coverage)

(require "../listExps.rkt")

(define all-tests
  (test-suite  "ListExps"

    ;; Null/empty lists
    ;;
    (test-case  "null/empty list expressions"
      (let ([null-lst0 '(null)]
            [null-lst  (null-list-exp)]
            [lst       '( () ())]
           )
        ;; predicate
        ;;
        (check-true  (null-list-exp? null-lst0))
        (check-false (null-list-exp? lst))
        ;;
        ;; constructor
        ;;
        (check-true (null-list-exp? null-lst))
        (check-true (list? null-lst))
        (check eq?  (length null-lst) 1)
        ;;
        ;; NO extractors to test
      )
    )

    ;; cons lists
    ;;
    (test-case "cons list expressions"
      (let ([cons-lst0 '(cons list1 list2)]
            [cons-lst  (cons-list-exp 'list1 'list2)]
            [bad-cons  '(cons list1 list2 list3)]
            [lst       '( () ())]
           )
        ;; predicate
        ;;
        (check-true  (cons-list-exp? cons-lst0))
        (check-false (cons-list-exp? bad-cons))
        (check-false (cons-list-exp? lst))
        ;;
        ;; constructor
        ;;
        (check-true (cons-list-exp? cons-lst))
        (check-true (list? cons-lst))
        (check eq?  (length cons-lst) 3)
        (check eq?  (car   cons-lst) 'cons)
        (check eq?  (cadr  cons-lst) 'list1)
        (check eq?  (caddr cons-lst) 'list2)
        ;;
        ;; extractors
        ;;
        (check eq?  (cons-exp-car cons-lst) 'list1)
        (check eq?  (cons-exp-cdr cons-lst) 'list2)
      )
    )

    ;; Car lists
    ;;
    (test-case "car list expressions"
      (let ([car-lst0 '(car list1)]
            [car-lst  (car-list-exp 'list1)]
            [bad-car  '(car list1 list2)]
            [lst      '( () ())])
        ;; predicate
        ;;
        (check-true  (car-list-exp? car-lst0))
        (check-false (car-list-exp? bad-car))
        (check-false (car-list-exp? lst))
        ;;
        ;; constructor
        ;;
        (check-true  (car-list-exp? car-lst))
        (check eq?   (length  car-lst) 2)
        (check eq?   (car     car-lst) 'car)
        (check eq?   (cadr    car-lst) 'list1)
        ;;
        ;; extractors
        ;;
        (check eq?   (car-exp car-lst) 'list1)
      )
    )

    ;; Cdr lists
    ;;
    (test-case "cdr list expressions"
      (let ([cdr-lst0 '(cdr list1)]
            [cdr-lst  (cdr-list-exp 'list1)]
            [bad-cdr  '(cdr list1 list2)]
            [lst      '( () ())])
        ;; predicate
        ;;
        (check-true  (cdr-list-exp? cdr-lst0))
        (check-false (cdr-list-exp? bad-cdr))
        (check-false (cdr-list-exp? lst))
        ;;
        ;; constructor
        ;;
        (check-true  (cdr-list-exp? cdr-lst))
        (check eq?   (length  cdr-lst) 2)
        (check eq?   (car     cdr-lst) 'cdr)
        (check eq?   (cadr    cdr-lst) 'list1)
        ;;
        ;; extractors
        ;;
        (check eq?   (cdr-exp cdr-lst) 'list1)
      )
    )

    ;; List expressions (super data type)
    ;;
    (test-case "list expressions"
      (let ([null-lst  (null-list-exp)]
            [cons-lst  (cons-list-exp 'list1 'list2)]
            [bad-cons  '(cons list1 list2 list3)]
            [car-lst  (car-list-exp 'list1)]
            [bad-car  '(car list1 list2)]
            [cdr-lst  (cdr-list-exp 'list1)]
            [bad-cdr  '(cdr list1 list2)]
            [lst      '( () ())])
        (check-true  (list-exp? null-lst))
        (check-true  (list-exp? cons-lst))
        (check-false (list-exp? bad-cons))
        (check-true  (list-exp? car-lst))
        (check-false (list-exp? bad-car))
        (check-true  (list-exp? cdr-lst))
        (check-false (list-exp? bad-cdr))
        (check-false (list-exp? lst))
      )
    )
  )
)

(define ignore-value (run-tests all-tests 'verbose))
