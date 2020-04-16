// +build tests

// ANSI-C tests of the JoyLoL system using our cTests testing framework 
//

#include <stdio.h>
#include <string.h>
#include <memory.h>

#include "joylol.h"
#include "joylolCTests.h"

#include "_cgo_export.h"
#include "cTests.h"

/// \brief Test the JBlock utilities
///
char *newJBlockCTest(void) {
  JBlock *aJBlock = newJBlock(100, 2);
  
  cTest_NotNil_MayFail("aJBlock nil", aJBlock);
  cTest_UIntEquals("wrong aJBlock.size", aJBlock->size, (size_t)(100*2));
  
  return 0;
}
