#include <stdio.h>
#include <string.h>

extern char* helloWorld(const char* aName) {
  
  // if aName is empty then say "Hello world!"
  if (!aName || strlen(aName) < 1) {
    return strdup("Hello world!\n");
  }
  
  // aName is not empty so say "Hello <aName>"
  char* helloBeg = "Hello ";
  char* helloEnd = "!\n";
  char* helloWorld =
    (char*) calloc(strlen(helloBeg) + strlen(aName) + strlen(helloEnd) + 1, sizeof(char));
  
  strcat(helloWorld, helloBeg);
  strcat(helloWorld, aName);
  strcat(helloWorld, helloEnd);
  
  return helloWorld;
}

