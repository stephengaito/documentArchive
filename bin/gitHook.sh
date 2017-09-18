#!/bin/sh
#
# Post-{commit, checkout, merge} hook to set version infomation

# Create the ANSI-C gitVersion.h file
#
gitVH=bin/gitVersion.h
#
git log -1 --date=short \
  --pretty=format:"
static const KeyValues gitKeyValues[] = {
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
gitVLua=bin/gitVersion.lua
#
git log -1 --date=short \
  --pretty=format:"
return {
  authorName      = \"%an\",
  commitDate      = \"%ad\",
  commitShortHash = \"%h\",
  commitLongHash  = \"%H\",
  subject         = \"%s\",
  notes           = \"%N\"
}
" HEAD > $gitVLua

# Now distribute these files to appropriate locations
#
cp $gitVLua core/lua/build
cp $gitVH   base/coAlgs/build
