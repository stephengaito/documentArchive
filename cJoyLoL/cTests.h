// +build tests

#define cTestLogf(...)            \
do {                              \
  char strBuff[1024];             \
  memset(strBuff, 0, 1024);       \
  sprintf(strBuff, __VA_ARGS__);  \
  cTestLog(strBuff);              \
} while (0)

#define cTestLogLineFile(aLine, aFile)    \
cTestLogf("  at line: %d in: %s", aLine, aFile)

#define cTest(message, test)    \
if (!(test)) cTestLog(message);

#define cTest_MayFail(message, test) \
if (!(test)) return message

#define cTest_NotNil_MayFail(message, aPtr) \
cTest_NotNil_MayFail_LineFile(message, aPtr, __LINE__, __FILE__)

#define cTest_NotNil_MayFail_LineFile(message, aPtr, aLine, aFile)  \
if ((aPtr) == 0) {                                                  \
  cTestLog(message);                                                \
  cTestLogLineFile(aLine, aFile);                                   \
  return message;                                                   \
}

#define cTest_UIntEquals(message, aUInt, bUInt)                       \
cTest_UIntEquals_LineFile(message, aUInt, bUInt, __LINE__, __FILE__)

#define cTest_UIntEquals_LineFile(message, aUInt, bUInt, aLine, aFile)  \
if ((aUInt) != (bUInt)) {                                               \
  cTestLog(message);                                                    \
  cTestLogf("  aUInt: %lu", aUInt);                                     \
  cTestLogf("  bUInt: %lu", bUInt);                                     \
  cTestLogLineFile(aLine, aFile);                                       \
}

