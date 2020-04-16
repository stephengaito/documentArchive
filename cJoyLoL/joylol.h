
#ifndef JOYLOL_H
#define JOYLOL_H

/*! \file
\brief This is the cJoyLoL header file.

*/

#include <stdlib.h>

/// \brief The standard entries in all JObject structures.
///
#define JOBJ_BASE                   \
  struct DictionaryEntry *typeDict

/// \brief Treat a given JObject structure as a JObj.
///
#define AsJObj(anObj) ((JObj*)(anObj))

/// \brief A JObj is the base type of all JoyLoL objects.
///
/// Every JObj has an associated dictionary (linked list) of words. 
///
typedef struct JObj {
  JOBJ_BASE;
} JObj;

/// \brief A JType represents a specific JoyLoL type.
///
typedef struct JType {
  JOBJ_BASE;

  struct DictionaryEntry *dict;
} JType;

/// \brief A JBlock is a RegisterMachine block of contiguous memory. 
//
typedef struct JBlock {
  JOBJ_BASE;
  size_t  size;
  struct JBlock *next;
} JBlock;

extern JBlock *newJBlock(size_t subBlockSize, size_t numSubBlocks );


/// \brief JDictEntry represents one JoyLoL word.
///
/// A JDictEntry is part of a singly linked list of JDictEntries which 
/// together form a JoyLoL dictionary. We expect JoyLoL dictionaries to be 
/// short lists of JoyLoL words specific to a particular JoyLoL type. 
///
/// A JDictEntry consists of a name, and two definitions, the first is a 
/// text code listing for use in inlining the code, the second is the 
/// actual compiled code which implements the definition. 
///
typedef struct JDictEntry {
  JOBJ_BASE;

  /// The size of the defined name
  size_t nameSize; 
  
  struct DictionaryEntry *next;
  
  struct JType *type;
  
} JDictEntry;

#endif