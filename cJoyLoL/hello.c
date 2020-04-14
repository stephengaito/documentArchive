#include <stdio.h>


#include "hello.h"


int factorial ( int n) {
  if (n <= 1) {
    return 1;
  }
  return n * factorial(n-1);
}

void sayHello(void) {
  int n, result;
  n = 10;
  result = factorial(n);
  printf("Hello world! %d\n", result);
}