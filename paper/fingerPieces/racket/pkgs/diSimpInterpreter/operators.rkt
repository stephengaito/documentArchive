#lang diSimpRacketLayer

(require (submod diSimpInterpreter/utils privateAPI))

(provide 
  noopTag
  popTag
  consTag
  treeTag
  unTreeTag
  newTreeTag
)

(module+ privateAPI
  (provide
    noopList
    noopOp
    popList
    popOp
    consList
    consOp
    treeList
    treeOp
    unTreeList
    unTreeOp
    newTreeList
    newTreeOp
  )
)

;; makes no change to either tree
;;
(define noopTag (diSimpTag 0) )
(define noopList (list noopTag) )
(define (noopOp pTree fTree) (cons pTree fTree))

;; pops the top of the fTree off
;;
(define popTag  (diSimpTag 1) )
(define popList (list popTag) )
(define (popOp pTree fTree) (cons pTree (cdr fTree)) )

;; pops the top two items on the fTree
;; and replaces them with their cons
;;
(define consTag (diSimpTag 2) )
(define consList (list consTag) )
(define (consOp pTree fTree)
  (cons pTree 
    (cons (list (car fTree) (cadr fTree)) (cddr fTree))
  )
)

;; pushes the current fTree onto the top of the fTree
;;
;; is this too powerful?
;;
(define treeTag (diSimpTag 3) )
(define treeList (list treeTag) )
(define (treeOp pTree fTree) (cons pTree (cons fTree fTree)) )

;; replaces the Tree with the current top of the fTree
;;
(define unTreeTag (diSimpTag 4) )
(define unTreeList (list unTreeTag) )
(define (unTreeOp pTree fTree) (cons pTree (list (car fTree))) )

;; empties the fTree
;;
(define newTreeTag (diSimpTag 5) )
(define newTreeList (list newTreeTag) )
(define (newTreeOp pTree fTree) (cons pTree '(())) )
