
/// \file
/// \brief The main entry point into the JoyLoL interpreter
///
/// Documentation: See: https://stackoverflow.com/a/7737162
///

#include <stdio.h>
#include "joylol.h"

JBlock *newJBlock(size_t subBlockSize, size_t numSubBlocks) {
  /// This is some more detailed documentation about the implementation of 
  /// newJBlock. 
  ///
  /// It is a test of doxygen.
  ///
  size_t lSize = subBlockSize * numSubBlocks;
  JBlock *newBlock = (JBlock*)calloc(1, lSize + sizeof(JBlock));
  newBlock->size = lSize;
  return newBlock;
}

JRM64 *newJRM64(void) {
  JRM64 *newRM = (JRM64*)newJBlock(sizeof(JRM64), 1);
  return newRM;
}
