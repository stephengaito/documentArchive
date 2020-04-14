

//package cJoyLoL
package main

/*
#include "go_tls.h"
#include "go_asm.h"
#include "hello.h"
*/

//include "hello.h"
import "C"

import (
  //"unsafe"
)

func main() {
  C.sayHello()
}

