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

# Create the ConTeXt gitVersion-tex.tex file
#
gitVTex=bin/gitVersion-tex.tex
#
git log -1 --date=short \
  --pretty=format:"
\startMkIVCode
%%  authorName      = \"%an\",
%%  commitDate      = \"%ad\",
%%  commitShortHash = \"%h\",
%%  commitLongHash  = \"%H\",
%%  subject         = \"%s\",
%%  notes           = \"%N\"
\stopMkIVCode
" HEAD > $gitVTex

# Now distribute these files to appropriate locations
#
cp $gitVTex module/t-joylol-coalg/doc/context/third/joyLoLCoAlg
cp $gitVLua module/t-joylol-coalg/doc/context/third/joyLoLCoAlg
cp $gitVC   module/t-joylol-coalg/doc/context/third/joyLoLCoAlg

cp $gitVTex core/context/joylol/t-joylol/doc/context/third/joyLoL
cp $gitVLua core/context/joylol/t-joylol/doc/context/third/joyLoL
cp $gitVC   core/context/joylol/t-joylol/doc/context/third/joyLoL

cp $gitVTex core/context/options/t-joylol-opts/doc/context/third/joyLoLOpts
cp $gitVLua core/context/options/t-joylol-opts/doc/context/third/joyLoLOpts
cp $gitVC   core/context/options/t-joylol-opts/doc/context/third/joyLoLOpts

cp $gitVTex core/lua/doc
cp $gitVLua core/lua/doc
cp $gitVC   core/lua/doc

cp $gitVTex core/textadept/doc
cp $gitVLua core/textadept/doc
cp $gitVC   core/textadept/doc

cp $gitVTex base/booleans/doc
cp $gitVC   base/booleans/doc
cp $gitVTex base/cFunctions/doc
cp $gitVC   base/cFunctions/doc
cp $gitVTex base/coAlgebras/doc
cp $gitVC   base/coAlgebras/doc
cp $gitVTex base/contexts/doc
cp $gitVC   base/contexts/doc
cp $gitVTex base/crossCompilers/doc
cp $gitVC   base/crossCompilers/doc
cp $gitVTex base/dictNodes/doc
cp $gitVC   base/dictNodes/doc
cp $gitVTex base/fragments/doc
cp $gitVC   base/fragments/doc
cp $gitVTex base/jInterps/doc
cp $gitVC   base/jInterps/doc
cp $gitVTex base/loaders/doc
cp $gitVC   base/loaders/doc
cp $gitVTex base/luaFunctions/doc
cp $gitVC   base/luaFunctions/doc
cp $gitVTex base/naturals/doc
cp $gitVC   base/naturals/doc
cp $gitVTex base/pairs/doc
cp $gitVC   base/pairs/doc
cp $gitVTex base/parsers/doc
cp $gitVC   base/parsers/doc
cp $gitVTex base/stringBuffers/doc
cp $gitVC   base/stringBuffers/doc
cp $gitVTex base/symbols/doc
cp $gitVC   base/symbols/doc
cp $gitVTex base/templates/doc
cp $gitVC   base/templates/doc
cp $gitVTex base/texts/doc
cp $gitVC   base/texts/doc
