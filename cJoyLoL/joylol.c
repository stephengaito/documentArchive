
/// \file
/// \brief The main entry point into the JoyLoL interpreter

#include <stdio.h>
#include "joylol.h"

/// Create a new JBlock of size ``size``.
//
JBlock *newJBlock(size_t size) {
  JBlock *newBlock = (JBlock*)calloc(1, size);
  newBlock->size = size;
  return newBlock;
}
