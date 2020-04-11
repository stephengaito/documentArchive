# goJoyLoL

A purely developmental embedding of JoyLoL in go.

## Goals

1. To explore the underlying architecture for a Forth-like implementation 
of JoyLoL. 

2. To provide an IPython interface to JoyLoL based upon gophernotes 
implementation of IPython. 

3. To provide a multi-core/multi-CPU parallel implementation of JoyLoL 
using goroutines intra-CPU and either a RESTful HTTP or ZeroMQ inter-CPU 
interface. 

## Resources

- https://blog.golang.org/cgo
- https://golang.org/cmd/cgo/
- https://golang.org/misc/cgo/testcshared/cshared_test.go

- https://github.com/gopherdata/gophernotes
