// +build tests

package cJoyLoL

// #include "cTests.h"
import "C"

import (
  "errors"
  "fmt"
  "testing"
)

func cTestStart(cTestName string) {
  fmt.Printf("\n Starting: %s\n", cTestName)
}
//export cTestLog
func cTestLog(cTestMessage *C.char) {
  if cTestMessage != nil {
    fmt.Printf("  %s\n", C.GoString(cTestMessage))
  }
}

func cTestFinish(cTestName string) {
  fmt.Printf("Finishing: %s\n\n", cTestName)
}

func cTestPossibleError(possibleErrorMessage *C.char) error {
  if possibleErrorMessage != nil {
    return errors.New(C.GoString(possibleErrorMessage))
  }
  return nil
}

func cTestMayBeError(t *testing.T, message string, aPossibleError error) {
  if aPossibleError != nil {
    t.Errorf("%s\nerror: %s", message, aPossibleError.Error())
  }
}