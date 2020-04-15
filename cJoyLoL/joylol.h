
#ifndef JOYLOL_H
#define JOYLOL_H

/*! \file
\brief This is the cJoyLoL header file.

*/

#include <stdlib.h>

/// A JBlock is a RegisterMachine block of contiguous memory.
//
typedef struct JBlock {
  size_t  size;
  struct JBlock *next;
} JBlock;

extern JBlock *newJBlock(size_t size);

#endif