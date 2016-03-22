# racketLayer

## Notes

To determine what symbols are exported from a module, require that module 
and then type "(module->exports '<module-name>)" (note the "'"). This 
will list the symbols exported at each phase.

We have essentially two options:

1. We can program a straight interpreter (a'la EOPL), OR

2. We can use Racket's macro system to extend the existing compiler to 
translate math syntax into a restricted pure LISP syntax which is then 
run by the Racket/Lisp engine.

Both options will involve roughly the same code, just written in a 
different format.  The second "cross-compiler" method uses Racket's 
strengths, and has a slightly more meta-mathematical structure.

We need to build a tool to automatically display what syntax is developed 
at what level.

## Original main

> #lang racket/base
>
> (module+ test
>  (require rackunit))
> 
> ;; Notice
> ;; To install (from within the package directory):
> ;;   $ raco pkg install
> ;; To install (once uploaded to pkgs.racket-lang.org):
> ;;   $ raco pkg install <<name>>
> ;; To uninstall:
> ;;   $ raco pkg remove <<name>>
> ;; To view documentation:
> ;;   $ raco doc <<name>>
> ;;
> ;; For your convenience, we have included a LICENSE.txt file, which links to
> ;; the GNU Lesser General Public License.
> ;; If you would prefer to use a different license, replace LICENSE.txt with the
> ;; desired license.
> ;;
> ;; Some users like to add a `private/` directory, place auxiliary files there,
> ;; and require them in `main.rkt`.
> ;;
> ;; See the current version of the racket style guide here:
> ;; http://docs.racket-lang.org/style/index.html
> 
> ;; Code here
> 
> (module+ test
>   ;; Tests to be run with raco test
>   "Hello testing world"
>   )
> 
> (module+ main
>   ;; Main entry point, executed when run with the `racket` executable or DrRacket.
>   "Hello world"
>   )

