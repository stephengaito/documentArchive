
#ifndef JOYLOL_H
#define JOYLOL_H

/*! \file
\brief This is the cJoyLoL header file.

*/

#include <stdlib.h>
#include <stdint.h>

/// \brief JoyLoL unsigned 8 bit integer 
typedef uint8_t  JUint8;

/// \brief JoyLoL signed 8 bit integer 
typedef int8_t   JInt8;

/// \brief JoyLoL unsigned 16 bit integer 
typedef uint16_t JUInt16;

/// \brief JoyLoL signed 16 bit integer 
typedef int16_t  JInt16;

/// \brief JoyLoL unsigned 32 bit integer 
typedef uint32_t JUInt32;

/// \brief JoyLoL signed 32 bit integer 
typedef int32_t  JInt32;

/// \brief JoyLoL unsigned 64 bit integer 
typedef uint64_t JUInt64;

/// \brief JoyLoL signed 64 bit integer 
typedef int64_t  JInt64;

/// \brief (JoyLoL) Register Machine Pointer
typedef void*    RMPtr;

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


/// \brief Create a new JBlock of size ``size``.
///
/// \param subBlockSize size_t the size of each item in the JBlock
/// \param numSubBlocks size_t the number of items in the JBlock
/// \returns a single JBlock with space to store numSubBlocks of size 
/// subBlockSize 
/*@
 requires subBlockSize > 0 && numSubBlocks > 0;
///
/// this is a test
///
 allocates \result;
///
/// this is another test
///
 ensures \valid(\result);
 ensures \result->size == subBlockSize * numSubBlocks;
*/
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


/// \brief JRM64 represents a single 64 bit Register Machine
///
typedef struct JRM64 {
  JOBJ_BASE;
  
  
} JRM64;

extern JRM64 *newJRM64(void);

// need JString
// need JInt / JUInt
//

// Question: How do I deal with the memory requirements of variable length 
// strings/ints? Are they immutable? How long lived are they generally? Do 
// strings and ints vary in their longevity (re-usability)?

// Long lived objects can be assigned directly a JBlock (ie directly off 
// the underlying heap). Short lived objects should be assigned from a 
// pool of same sized objects to help make reuse easier. 

// For JInts we can have the generic JInts directly off JBlocks. But 
// specific JIntXXXs as pools of same sized objects. 

// For JStrings?? How to determing short vs long lived strings... should 
// we have JString allocated as a JBlock and JStrXXXXs, say JStr256 or 
// JStr1024, for short lived strings allocated from a pool of same sized 
// objects? 

// Need JPair

// Need JCFunc
// Need JPFunc (packed func of JObjPtr)

// How do I allow sequences of mixed Funcs? Do I have Func references 
// which have the lowest bit set for packed funcs and unset for CFuncs? 

// How does the func interpreter deal with litterals? We use a quote 
// function which takes the next reference and pushs it on the data stack. 

// So PFuncs are really packed arrays of JObj's, ie. short sequences of 
// packed process stacks. 

// What is a JObjPtr? How "big" is it? It clearly depends upon a specific 
// RegisterMachine size. So do we have RegisterMachine and 
// RegisterMachineXXX? In a RegisterMachine JObjPtr would be a JInt. BUT 
// we get into an infinite regress... since a JInt must somewhere defined 
// its (current) maximum size... as a JInt?!?!? 

// However RegisterMachine64 does make sense... and clearly describe's its 
// limitiations. 

// We *can* implement a RegisterMachine as a confederation of (limited) 
// RegisterMachineXXXs. In this case the JObjPtr contains a size parameter 
// which varies as the over all RegisterMachine "grows" in "size". That 
// is, if the RegisterMachine needs to up-size itself, it needs to 
// instruct all of the confederated machines to up-size their JObjPts. 

#endif 

