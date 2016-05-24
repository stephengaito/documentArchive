#lang racket

(require "../../server/restfulServlets.rkt")
(require "../../server/dseFramework.rkt")

;; List the javascript files required to run Jasmine.js
;;
(define jasmine-js
  (list 
    "/jasmine/jasmine.js"
    "/jasmine/jasmine-html.js"
    "/jasmine/boot.js"
  )
)

;; capture the required paths for our local work
;;
(require racket/runtime-path)
(define-runtime-path jasmine-java-script "../browser/vendor/jasmine")
(define-runtime-path specs-java-script "../browser")

;; create a list of the various specification files
;;
(define curDir (current-directory))
(current-directory "specs/browser")
;;
(define functional-specs 
  (for/list
    ( [ aFile (in-directory "functional")] 
      #:when (regexp-match? #rx"\\.js$" aFile)
    )
    (string-append "/specs/" (path->string aFile))
  )
)
;;
(define integration-specs 
  (for/list
    ( [ aFile (in-directory "integration")] 
      #:when (regexp-match? #rx"\\.js$" aFile)
    )
    (string-append "/specs/" (path->string aFile))
  )
)
;;
(define unit-specs 
  (for/list
    ( [ aFile (in-directory "unit")] 
      #:when (regexp-match? #rx"\\.js$" aFile)
    )
    (string-append "/specs/" (path->string aFile))
  )
)
;;
(current-directory curDir)

;; Build the HTML parts from which we assemble each page
;;
(define header-preamble #<<END-OF-PREAMBLE
<html>
  <head>
    <title>diSimpExplorer Specification checking</title>
    <link rel="icon" type="image/png"
      href="/jasmine/jasmine_favicon.png" />
    <link rel="stylesheet" (type="text/css"
      href="/jasmine/jasmine.css" />

END-OF-PREAMBLE
)
;;
(define html-postamble #<<END-OF-POSTAMBLE
  </head>
  <body>
    <nav class="dseNavigation">
      <ul>
        <li><a href="/all">All</a></li>
        <li><a href="/functional">Functional</a></li>
        <li><a href="/integration">Integration</a></li>
        <li><a href="/unit">Unit</a></li>
        <li><a href="/quit">Quit</a></li>
      </ul>
    </nav>
    <div class="dseWindow"><iframe src="/"></iframe></div>
  </body>
</html>
END-OF-POSTAMBLE
)
;;
(define (path->scriptStrings aPath)
  (list
    "    <script type=\"text/javascript\" src=\""
    aPath
    "\"></script>\n"
  )
)

;; Define the various pages/servlets
;;
(get "/all" 
  (lambda ()
    (string-append*
      (flatten 
        (list 
          header-preamble
          (map path->scriptStrings zepto-js)
          (map path->scriptStrings jasmine-js)
          (map path->scriptStrings functional-specs)
          (map path->scriptStrings integration-specs)
          (map path->scriptStrings unit-specs)
          html-postamble
        )
      )
    )
  )
)
;;
(get "/functional" 
  (lambda ()
    (string-append*
      (flatten 
        (list 
          header-preamble
          (map path->scriptStrings zepto-js)
          (map path->scriptStrings jasmine-js)
          (map path->scriptStrings functional-specs)
          html-postamble
        )
      )
    )
  )
)
;;
(get "/integration" 
  (lambda ()
    (string-append*
      (flatten 
        (list 
          header-preamble
          (map path->scriptStrings zepto-js)
          (map path->scriptStrings jasmine-js)
          (map path->scriptStrings integration-specs)
          html-postamble
        )
      )
    )
  )
)
;;
(get "/unit" 
  (lambda ()
    (string-append*
      (flatten 
        (list 
          header-preamble
          (map path->scriptStrings zepto-js)
          (map path->scriptStrings jasmine-js)
          (map path->scriptStrings unit-specs)
          html-postamble
        )
      )
    )
  )
)

(require "../../server/binaryServlets.rkt")
(get-file "/jasmine" jasmine-java-script 3600 )
(get-file "/specs"   specs-java-script 0 )
