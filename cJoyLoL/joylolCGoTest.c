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
/// \silly This is a silly comment
///
char *newJBlockCTest(void) {
  JBlock *aJBlock = newJBlock(100, 2);
  
  cTest_NotNil_MayFail("aJBlock nil", aJBlock);
  cTest_UIntEquals("wrong aJBlock.size", aJBlock->size, (size_t)(100*2));
  
  return 0;
}

/// \brief Test the RM64 utilities
///
char *newJRM64CTest(void) {
  JRM64 *aRegisterMachine = newJRM64();
  
  cTest_NotNil_MayFail("aRegisterMachine nil", aRegisterMachine);
  
  return 0;
}