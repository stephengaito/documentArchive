// +build tests

// GoLang level wrappers of the corresponding ANSI-C tests.
//
// This *should* be located in joylolCTests_test.go...
// ... unfortunately `go test` forbids the use of cgo...
// ... so we need to maintain this addition level of code indirection.
//

package cJoyLoL

// #include "joylolCTests.h"
import "C"

import (
)

// Test the JBlock utilities
//
func NewJBlockTest() error {
  cTestStart("newJBlockCTest");
  defer cTestFinish("newJBlockCTest");
  
  return cTestPossibleError(C.newJBlockCTest())
}
