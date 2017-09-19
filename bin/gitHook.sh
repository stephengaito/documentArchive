#!/bin/sh
#
# Post-{commit, checkout, merge} hook to set version infomation

# Create the ANSI-C gitVersion-c.tex file
#
gitVC=bin/gitVersion-c.tex
#
git log -1 --date=short \
  --pretty=format:"
\startCCode
static const KeyValues gitVersionKeyValues[] = {
  { \"authorName\",      \"%an\"},
  { \"commitDate\",      \"%ad\"},
  { \"commitShortHash\", \"%h\"},
  { \"commitLongHash\",  \"%H\"},
  { \"subject\",         \"%s\"},
  { \"notes\",           \"%N\"},
  { NULL,                NULL}
};
\stopCCode
" HEAD > $gitVC

# Create the Lua gitVersion-lua.tex file
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
cp $gitVC   base/booleans/doc
cp $gitVC   base/coAlgs/doc
