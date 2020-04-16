
/// \file
/// \brief The main entry point into the JoyLoL interpreter

#include <stdio.h>
#include "joylol.h"

/// Create a new JBlock of size ``size``.
//
JBlock *newJBlock(size_t subBlockSize, size_t numSubBlocks) {
  JBlock *newBlock = (JBlock*)calloc(numSubBlocks, subBlockSize);
  newBlock->size = subBlockSize * numSubBlocks;
  return newBlock;
}


