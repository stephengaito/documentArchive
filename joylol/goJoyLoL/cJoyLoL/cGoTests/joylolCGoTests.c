// ANSI-C tests of the JoyLoL system using our cTests testing framework 
//

#include <stdio.h>
#include <string.h>
#include <memory.h>

#include "joylol.h"
#include "cJoyLoLCGoTests.h"

#include "_cgo_export.h"
#include "cGoTests.h"

/// \testFixture utils Test the utilities

/// \brief Test the JBlock utilities
/// \inFixture utils
///
char *newJBlockCGoTest(void* data) {
  JBlock *aJBlock = newJBlock(100, 2);
  
  cGoTest_NotNil_MayFail("aJBlock nil", aJBlock);
  cGoTest_UIntEquals("wrong aJBlock.size", aJBlock->size, (size_t)(100*2));
  
  return 0;
}

/// \brief Test the RM64 utilities
/// \inFixture utils
///
char *newJRM64CGoTest(void* data) {
  JRM64 *aRegisterMachine = newJRM64();
  
  cGoTest_NotNil_MayFail("aRegisterMachine nil", aRegisterMachine);
  
  return 0;
}