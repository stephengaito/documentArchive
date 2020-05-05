
/// \file
/// \brief The main entry point into the JoyLoL interpreter

#include <stdio.h>
#include "joylol.h"

/// \brief Create a new JBlock of size ``size``.
//
JBlock *newJBlock(size_t subBlockSize, size_t numSubBlocks) {
  size_t lSize = subBlockSize * numSubBlocks;
  JBlock *newBlock = (JBlock*)calloc(1, lSize + sizeof(JBlock));
  newBlock->size = lSize;
  return newBlock;
}


JRM64 *newJRM64(void) {
  JRM64 *newRM = (JRM64*)newJBlock(sizeof(JRM64), 1);
  return newRM;
}