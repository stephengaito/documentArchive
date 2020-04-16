
// GoLang level tests for the cJoyLoL ANSI-C code

package cJoyLoL

import (
  "testing"
)

// Test the JBlock utilities
//
func TestNewJBlock(t *testing.T) {
  cTestMayBeError(t, "NewJBlockTest", NewJBlockTest())
}
