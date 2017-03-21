#include <stdlib.h>
#include <stdio.h>

#include "lua.h"
#include "lauxlib.h"
#include "joyLoL.h"

static int luaHelloWorld (lua_State *L) {
  const char *aName = luaL_checkstring(L, 1);
  const char *aResponse = helloWorld(aName);
  lua_pushstring (L, aResponse);
  free((void*)aResponse);
  return 1;
}

static const struct luaL_Reg joyLoLFuncs [] = {
  {"helloWorld", luaHelloWorld},
  {NULL, NULL} /* sentinel */
};

int luaopen_joyLoLC (lua_State *L) {
  luaL_newlib(L, joyLoLFuncs);
  return 1;
}
