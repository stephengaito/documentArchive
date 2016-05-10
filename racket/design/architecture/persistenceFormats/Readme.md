**Table of Contents**

  - [Persistence formats](#persistence-formats)
    - [Problem](#problem)
    - [Goals](#goals)
    - [Requirements](#requirements)
    - [Solution](#solution)

<!--- END TOC -->

# Persistence formats

## Problem

We have four primary artefacts:

 1. a description of a language's syntax.

 1. a list of a language's axioms.

 1. one or more computational theorem statements together with their 
    proofs

 1. a description of an interpretation of one language into another.

For each of these primary artefacts we have the problem of storing and 
navigating over large collections.

## Goals

## Requirements

> Persistent artefacts WILL be stored in Racket readable files.

> Collections of a persistence artefacts WILL be stored in a file system 
> directory tree.

## Solution