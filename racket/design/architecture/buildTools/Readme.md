# Build layout and tools

## Problem

We need to coordinate the inter-working of a number of third party tools 
and or packages in both javascript for the browser and Racket for 
various command line tools and a simple (local) webserver.

This requires "storing" original packages as downloaded and "installed" 
by each tool's native installation requirements.

We need "convenient" locations in which to develop our own code.

We also need to compile and/or minify the javascript and CSS.

The most complex layout and collection of tools will be those required 
by the diSimpExplorer's browser frontend and webserver backend 
structure.

## Goals

Our objective is to automate as much of this process as possible.

We want to keep the location of each differnt type of tool/code as 
distinct and obvious as possible.

## Requirements

> Any non-Racket artefacts MUST be kept seperate from the Racket code.

## Solution

The diSimpExplorer's browser implementation will use the following 
tools:

  * [node.js](https://nodejs.org/en/) and 
    [npm.js](https://www.npmjs.com/) to manage the javascript packages.

  * [gulp.js](http://gulpjs.com/) to manage the installation and 
    scripting of the javascript and CSS packages.

  * [Zepto.js](http://zeptojs.com/) to help cooridnate the browser 
    functionality.

  * [Jasmine.js](http://jasmine.github.io/2.4/introduction.html) to check 
    the browser specifications.

  * [Uglify.js](https://github.com/mishoo/UglifyJS2) to minify the 
    various javascript artefacts.

  * [SASS](http://sass-lang.com/) to manage/compile the CSS artefacts.

  * [Autoprefixer](https://github.com/postcss/autoprefixer) to manage 
    cross browser CSS.

  * We *might* use either of 
    [TypeScript](https://www.typescriptlang.org/) or 
    [Babel](https://babeljs.io/) to compile javascript... or we might 
    simply use javascript directly.

The diSimpExplorer layout will be as follows:

* **diSimpExplorer** any command line scripts and/or configuration 
  files required by the whole diSimpExplorer project.

  * **browser** a collection of javascript and CSS code required to 
    orchestrate the browser.

    * **vendor** a collection of the minified javascript and CSS code 
      for the vendor supplied packages.

  * **server** the collection of our Racket code used to implement the
    webserver functionality. The primary diSimplicial racket code will 
    be found in either the diSimp, diSimpCompiler or diSimpInterpreter 
    Racket packages.

  * **specs**

    * **browser**

      * **functional** the functional specifications for the browser
        implementation.

      * **integration** the integration specficiations for the browser
        implementation.

      * **unit** the unit specifications for the browser implementation.

      * **vendor** a collection of the minified javascript and CSS code 
        required for to check the specifications.

    * **server**

      * **functional** the functional specifications for the server
        implementation.

      * **integration** the integration specficiations for the server
        implementation.

      * **unit** the unit specifications for the server implementation.

  * **vendor** any "local" configuration files and/or scripts required 
    to describe the vendor packages/tools required.

    * **node_modules** a collection of subdirectories one for each npm 
      package such as: zepto.js, jasmine.js, uglify.js
