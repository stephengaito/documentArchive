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

The diSimpExplorer layout will be as follows:

* **diSimpExplorer** 

  * **browser** a collection of javascript and CSS code required to 
    orchestrate the browser.

  * **server** a collection of Racket code

  * **specs**

    * **browser**

    * **server**

  * **vendor** any "local" configuration files and/or scripts required 
    to describe the vendor packages/tools required.

    * **node_modules** a collection of subdirectories one for each npm 
      package such as: zepto.js, jasmine.js, uglify.js
