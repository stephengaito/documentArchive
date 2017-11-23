-- A Lua file

-- from file: preamble.tex after line: 50

-- This is the lua code associated with t-joylol-coalg.mkiv

if not modules then modules = { } end modules ['t-joylol-coalg'] = {
    version   = 1.000,
    comment   = "joylol coalgegraic extensions - lua",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata        = thirddata        or {}
thirddata.joylol = thirddata.joylol or {}

local joylol     = thirddata.joylol

local coAlgs     = thirddata.joyLoLCoAlgs
coAlgs.theCoAlg  = {}
local theCoAlg   = coAlgs.theCoAlg

local litProgs   = thirddata.literateProgs or {}
litProgs.build   = litProgs.build or {}
local build      = litProgs.build

local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring

-- **Problem**: we can not assume that a user *has* a compiled and working
-- C based JoyLoL. This is the "Bootstrapping (Compiler)" problem (see
-- Wikipedia). We solve this problem by writing a minimal joyLoL
-- interpreter in Lua.

-- SO we first check to see if the joyLoL (C shared libraries) exists and
-- can be required, if it can not be loaded, we load the joyLoLMinLua
-- version instead.

-- The following conditional require is adapted from: shuva's answer to
--  "How to check if a module exists in Lua?"
-- see: http://stackoverflow.com/a/22686090

--local hasJoyLoL,joylol = pcall(require, "joylol/joylol")
--if not hasJoyLoL then
--  interfaces.writestatus("joyLoL",
--    "Could NOT load joyLoL... loading mininal Lua version instead.")
--  joylol = require 'joylolMinLua/joylol'
--end

--coAlgs.joylol = joylol

local pushData, pushProcess = joylol.pushData, joylol.pushProcess
local pushProcessQuoted = joylol.pushProcessQuoted
local popData, popProcess   = joylol.popData, joylol.popProcess
local newList, newDictionary = joylol.newList, joylol.newDictionary
local jEval = joylol.eval

if joylol.core then
  interfaces.writestatus(
    "joyLoL",
    joylol.core.context.gitVersion('commitDate')
  )
else
  interfaces.writestatus(
    "joyLoL",
    "partially loaded"
  )
end

-----------------------------------------------------------------------------
-- NOTE the following uses raw JoyLoL code to collect the coAlgebra's
-- literate code description.

-- To understand this code.... **think categorically**

-- In JoyLoL a particular object in the category *is* the structure of the
-- data stack, while a particular arrow in the category *is* the process
-- stack.

-- To understand what these arrows are doing... you read the JoyLoL code
-- in reverse order (from a 'jEval' up).
-----------------------------------------------------------------------------

local function addNewDict(aCtx, dictName)
  pushProcess(aCtx, 'addToDict')
  newDictionary(aCtx)
  pushProcessQuoted(aCtx, dictName)
end

local function addNewList(aCtx, listName)
  pushProcess(aCtx, 'addToDict')
  newList(aCtx)
  pushProcess(aCtx, listName)
end

local function addStrToListNamed(aCtx, aStr, listName)
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, aStr) -- need to explicitly quote this string
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, listName)
end

local function writeCodeFile(aCtx, coAlgName, templateName, filePath, fileExt)
  local outFilePath = string.format('%s/%s.%s', filePath, coAlgName, fileExt)
  local outFile = io.open(outFilePath, 'w')
  outFile:write(pp.write(theCoAlg))
  pushProcess(aCtx, 'render')
  pushProcess(aCtx, 'getTemplate')
  pushProcessQuoted(aCtx, templateName)
  jEval(aCtx)
  local renderedBaseTemplate = popData(aCtx)
  texio.write_nl(renderedBaseTemplate)
  outFile:write('\n')
  outFile:write(renderedBaseTemplate)
  outFile:write('\n')
  outFile:close()
end

function coAlgs.createCoAlg()
  texio.write_nl("createCoAlg...")
  if not theCoAlg then return end
  local coAlgName = theCoAlg.name or 'unknown'
  texio.write_nl(string.format('creating JoyLoL CoAlgebra: [%s]', coAlgName))
  --
  local aCtx = theCoAlg.ctx
  coAlgs.loadTemplates(aCtx) -- contains a jEval
  --
  if theCoAlg.hasCHeader    then writeCodeFile(aCtx, coAlgName, 'cHeader',    'build', 'h')   end
  if theCoAlg.hasCCode      then writeCodeFile(aCtx, coAlgName, 'cCode',      'build', 'c')   end
  if theCoAlg.hasLuaCode    then writeCodeFile(aCtx, coAlgName, 'luaCode',    'build', 'lua') end
  if theCoAlg.hasJoyLoLCode then writeCodeFile(aCtx, coAlgName, 'joyLoLCode', 'build', 'joy') end
  --
  texio.write_nl(string.format(' created JoyLoL CoAlgebra: [%s]', coAlgName))
end

function coAlgs.newWord(wordName)
  texio.write_nl('newWord: ['..wordName..']')
  theCoAlg.curWord    = wordName
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'addToDict')
  addNewList(aCtx, 'preData')
  addNewList(aCtx, 'postData')
  addNewList(aCtx, 'preProcess')
  addNewList(aCtx, 'postProcess')
  addNewList(aCtx, 'joyLoLCode')
  addNewList(aCtx, 'cHeader')
  addNewList(aCtx, 'cCode')
  addNewList(aCtx, 'luaCode')
  newDictionary(aCtx)
  pushProcessQuoted(aCtx, wordName) -- need to explicitly quote this string
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'words')
  addStrToListNamed(aCtx, wordName, 'wordOrder')
  jEval(aCtx)
end

function coAlgs.endWord()
  theCoAlg.curWord = 'global'
end

function coAlgs.addPreDataStackDescription(name, condition)
  texio.write_nl('addPreDataStackDescription: ['..name..']['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, name)
  pushProcessQuoted(aCtx, 'name')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'preData')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addPostDataStackDescription(condition)
  texio.write_nl('addPostDataStackDescription: ['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'postData')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addPreProcessStackDescription(name, condition)
  texio.write_nl('addPreProcessStackDescription: ['..name..']['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, name)
  pushProcessQuoted(aCtx, 'name')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'preProcess')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addPostProcessStackDescription(condition)
  texio.write_nl('addPostProcessStackDescription: ['..condition..']')
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcess(aCtx, 'addToDict')
  pushProcessQuoted(aCtx, condition)
  pushProcessQuoted(aCtx, 'condition')
  newDictionary(aCtx) -- new dictionary for this condition
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'postProcess')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addJoyLoLCode(bufferName)
  texio.write_nl('addJoyLoLCode: ['..bufferName..']')
  theCoAlg.hasJoyLoLCode = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'joyLoLCode')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addCHeader(bufferName)
  texio.write_nl('addCHeader: ['..bufferName..']')
  theCoAlg.hasCHeader = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'cHeader')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addCCode(bufferName)
  texio.write_nl('addCCode: ['..bufferName..']')
  theCoAlg.hasCCode = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'cCode')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

function coAlgs.addLuaCode(bufferName)
  texio.write_nl('addLuaCode: ['..bufferName..']')
  theCoAlg.hasLuaCode = true
  local aCtx = theCoAlg.ctx
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'popData')
  pushProcess(aCtx, 'appendToEndList')
  pushProcessQuoted(aCtx, buffers.getcontent(bufferName))
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, 'luaCode')
  pushProcess(aCtx, 'lookupInDict')
  pushProcessQuoted(aCtx, theCoAlg.curWord)
  pushProcess(aCtx, 'lookupInDict')
  pushProcess(aCtx, 'words')
  jEval(aCtx)
end

coAlgs.joylol = joylol

interfaces.writestatus('joyLoLCoAlg', "loaded JoyLoL CoAlgs")

-- from file: codeManipulation.tex after line: 50

--local function newCoAlg(coAlgName)
--  theCoAlg[coAlgName] =
--    theCoAlg[coAlgName] or {}
--  local lCoAlg        = theCoAlg[coAlgName]
--  lCoAlg.name         = coAlgName
--  lCoAlg.words        = lCoAlg.words or {}
--  lCoAlg.words.global = {}
--end

local function newCoAlg(coAlgName)
  texio.write_nl('newCoAlg: ['..coAlgName..']')
  theCoAlg               = {}
  theCoAlg.name          = coAlgName
  theCoAlg.ctx           = nil --joylol.newContext()
  theCoAlg.hasJoyLoLCode = false;
  theCoAlg.hasLuaCode    = false;
  theCoAlg.hasCHeader    = false;
  theCoAlg.hasCCode      = false;
  build.coAlgsToBuild = build.coAlgsToBuild or {}
  tInsert(build.coAlgsToBuild, coAlgName)
  build.coAlgDependencies = build.coAlgDependencies or {}
  --
  --local aCtx = theCoAlg.ctx
  --pushProcess(aCtx, 'addToDict')
  --pushProcessQuoted(aCtx, coAlgName)
  --pushProcessQuoted(aCtx, 'coAlgName')
  --addNewList(aCtx, 'dependsOn')
  --addNewList(aCtx, 'wordOrder')
  --addNewDict(aCtx, 'words')
  --newDictionary(aCtx)
  --jEval(aCtx)
  --
  -- add the new word: "global"
  --
  --coAlgs.newWord('global')
end

coAlgs.newCoAlg = newCoAlg

-- from file: codeManipulation.tex after line: 100

local function createCoAlg()
end

joylol.createCoAlg = createCoAlg

-- from file: codeManipulation.tex after line: 200

local function addDependency(dependencyName)
  build.coAlgDependencies = build.coAlgDependencies or {}
  tInsert(build.coAlgDependencies, dependencyName)
  --texio.write_nl('addDependency: ['..dependencyName..']')
  --local aCtx = theCoAlg.ctx
  --pushProcess(aCtx, 'popData')
  --pushProcess(aCtx, 'appendToEndList')
  --pushProcessQuoted(aCtx, dependencyName)
  --pushProcess(aCtx, 'lookupInDict')
  --pushProcess(aCtx, 'dependsOn')
  --jEval(aCtx)
end

coAlgs.addDependency = addDependency

-- from file: codeManipulation.tex after line: 200

local function newWord(aWord)
end

joylol.newWord = newWord

-- from file: codeManipulation.tex after line: 250

local function endWord()
end

joylol.endWord = endWord

-- from file: codeManipulation.tex after line: 250

local function newStackActionIn(aWord)
end

joylol.newStackActionIn = newStackActionIn

-- from file: codeManipulation.tex after line: 250

local function endStackActionIn()
end

joylol.endStackActionIn = endStackActionIn

-- from file: codeManipulation.tex after line: 300

local function newStackActionOut(aWord)
end

joylol.newStackActionOut = newStackActionOut

-- from file: codeManipulation.tex after line: 300

local function endStackActionOut()
end

joylol.endStackActionOut = endStackActionOut

-- from file: codeManipulation.tex after line: 350

local function addPreDataStackDescription(arg1, arg2)
end

joylol.addPreDataStackDescription = addPreDataStackDescription

local function addPostDataStackDescription(arg1, arg2)
end

joylol.addPostDataStackDescription = addPostDataStackDescription

-- from file: codeManipulation.tex after line: 350

local function addPreProcessStackDescription(arg1, arg2)
end

joylol.addPreProcessStackDescription = addPreProcessStackDescription

local function addPostProcessStackDescription(arg1, arg2)
end

joylol.addPostProcessStackDescription = addPostProcessStackDescription

-- from file: codeManipulation.tex after line: 400

local function addCTestJoyLoLCallbacks(aCodeStream)
  thirddata.contests  = thirddata.contests  or { }
  local contests      = thirddata.contests
  contests.tests      = contests.tests      or { }
  local tests         = contests.tests
  tests.methods       = tests.methods       or { }
  local methods       = tests.methods
  methods.setup       = methods.setup       or { }
  local setup         = methods.setup
  setup.cTests        = setup.cTests        or { }
  local cTests        = setup.cTests
  aCodeStream         = aCodeStream         or 'default'
  cTests[aCodeStream] = cTests[aCodeStream] or { }
  tInsert(cTests[aCodeStream], [=[
void ctestsWriteStdOut(
  JoyLoLInterp *jInterp,
  Symbol       *aMessage
) {
  fprintf(stdout, "%s", aMessage);
}

void ctestsWriteStdErr(
  JoyLoLInterp *jInterp,
  Symbol       *aMessage
) {
  fprintf(stderr, "%s", aMessage);
}
void *ctestsCallback(
  lua_State *lstate,
  size_t resourceId
) {
  if (resourceId == JoyLoLCallback_StdOutMethod) {
    return (void*)ctestsWriteStdOut;
  } else if (resourceId == JoyLoLCallback_StdErrMethod) {
    return (void*)ctestsWriteStdErr;
  } else if (resourceId == JoyLoLCallback_Verbose) {
    return (void*)FALSE;
  } else if (resourceId == JoyLoLCallback_Debug) {
    return (void*)FALSE;
  }
  return NULL;
}
]=])
  tests.setup         = tests.setup         or { }
  setup               = tests.setup
  setup.cTests        = setup.cTests        or { }
  cTests              = setup.cTests
  cTests[aCodeStream] = cTests[aCodeStream] or { }
  tInsert(cTests[aCodeStream], [=[
setJoyLoLCallbackFrom(lstate, ctestsCallback);
]=])
end

joylol.addCTestJoyLoLCallbacks = addCTestJoyLoLCallbacks

-- from file: rules.tex after line: 50

local function startRule(ruleName)
  texio.write_nl("starting rule: ["..ruleName.."]")
end

coAlgs.startRule = startRule

local sectionHeaders = tConcat({
  'preDataStack',
  'preProcessStack',
  'preConditions',
  'postDataStack',
  'postProcessStack',
  'postConditions'
}, '|'):lower()

local function stopRule()
  local pp = require 'pl.pretty'
  local rulesBody  = buffers.getcontent('_rules_buffer_'):gsub("\13", "\n")
  local rules      = { }
  local lines      = { }
  local curSection = 'ignore'
  for aLine in rulesBody:gmatch("[^\r\n]+") do
    local aMatch = aLine:match("^%s*\\(%a+)%s*$")
    if aMatch and
      sectionHeaders:find(aMatch:lower(), 1, true)
    then
      rules[curSection] = lines
      lines             = { }
      curSection        = aMatch
    else
      tInsert(lines, aLine)
    end
  end
  rules[curSection] = lines
  texio.write_nl('---------rules-buffer-------------')
  texio.write_nl(pp.write(rules))
  texio.write_nl('---------rules-buffer-------------')
end


coAlgs.stopRule = stopRule

-- from file: lmsfile.tex after line: 0

local function addJoyLoLTargets(aCodeStream)
  build.existingDirs = build.existingDirs or { }
  tInsert(build.existingDirs, 'build/joylol')
  tInsert(build.existingDirs, 'install')
  tInsert(build.existingDirs, 'install/joylol')
  litProgs.setCodeStream('Lmsfile', aCodeStream)
  litProgs.markCodeOrigin('Lmsfile')
  local lmsfile = {}
  tInsert(lmsfile, "require 'lms.joyLoL'\n")
  tInsert(lmsfile, "joylol.targets{")
  tInsert(lmsfile, "  coAlgs = {")
  for i, aCoAlg in ipairs(build.coAlgsToBuild) do
    tInsert(lmsfile, "    '"..aCoAlg.."',")
  end
  tInsert(lmsfile, "  },")
  tInsert(lmsfile, "  srcFiles = {")
  for i, aSrcFile in ipairs(build.srcTargets) do
    tInsert(lmsfile, "    '"..aSrcFile.."',")
  end
  tInsert(lmsfile, "  },")
  tInsert(lmsfile, "  coAlgLibs = {")
  for i, aCoAlgDependency in ipairs(build.coAlgDependencies) do
    tInsert(lmsfile, "    '"..aCoAlgDependency.."',")
  end
  tInsert(lmsfile, "  },")
  tInsert(lmsfile, "  buildDir = 'build',")
  tInsert(lmsfile, "}")
  litProgs.setPrepend('Lmsfile', aCodeStream, true)
  litProgs.addCode.default('Lmsfile', tConcat(lmsfile, '\n'))
end

coAlgs.addJoyLoLTargets = addJoyLoLTargets