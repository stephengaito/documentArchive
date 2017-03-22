#include <stdlib.h>
#include <stdio.h>

#include "lua.h"
#include "lauxlib.h"
#include "joyLoL.h"

#include "version.h"
#include "gitVersion.h"

static int luaCVersion (lua_State *L) {
  lua_pushstring (L, JOYLOLC_VERSION);
  return 1;
}

static int luaCGitVersion (lua_State *L) {
  lua_createtable (L, 0, 10);
  for ( int i = 0; gitKeyValues[i].key; i++ ) {
    lua_pushstring(L, gitKeyValues[i].key);
    lua_pushstring(L, gitKeyValues[i].value);
    lua_settable(L, -1);
  }
  return 1;
}

static int luaHelloWorld (lua_State *L) {
  const char *aName = luaL_checkstring(L, 1);
  const char *aResponse = helloWorld(aName);
  lua_pushstring (L, aResponse);
  free((void*)aResponse);
  return 1;
}

static const struct luaL_Reg joyLoLFuncs [] = {
  {"cVersion",    luaCVersion},
  {"cGitVersion", luaCGitVersion},
  {"helloWorld",  luaHelloWorld},
  {NULL,          NULL} /* sentinel */
};

int luaopen_joyLoLC (lua_State *L) {
  luaL_newlib(L, joyLoLFuncs);
  return 1;
}
