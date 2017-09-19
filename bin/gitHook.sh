#!/bin/sh
#
# Post-{commit, checkout, merge} hook to set version infomation

# Create the ANSI-C gitVersion.h file
#
gitVH=bin/gitVersion.h
#
git log -1 --date=short \
  --pretty=format:"
static const KeyValues gitVersionKeyValues[] = {
  { \"authorName\",      \"%an\"},
  { \"commitDate\",      \"%ad\"},
  { \"commitShortHash\", \"%h\"},
  { \"commitLongHash\",  \"%H\"},
  { \"subject\",         \"%s\"},
  { \"notes\",           \"%N\"},
  { NULL,                NULL}
};
" HEAD > $gitVH

# Create the Lua gitVersion.lua file
#
gitVLua=bin/gitVersion-lua.tex
#
git log -1 --date=short \
  --pretty=format:"
\startLuaCode
local gitVersion = {
  authorName      = \"%an\",
  commitDate      = \"%ad\",
  commitShortHash = \"%h\",
  commitLongHash  = \"%H\",
  subject         = \"%s\",
  notes           = \"%N\"
}
\stopLuaCode
" HEAD > $gitVLua

# Now distribute these files to appropriate locations
#
cp $gitVLua core/lua/doc
cp $gitVH   base/coAlgs/build
