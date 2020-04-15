// +build tests

package cJoyLoL

// #include "joylolCTests.h"
import "C"

import (
)

func NewJBlockTest() error {
  cTestStart("newJBlockCTest");
  defer cTestFinish("newJBlockCTest");
  
  return cTestPossibleError(C.newJBlockCTest())
}
