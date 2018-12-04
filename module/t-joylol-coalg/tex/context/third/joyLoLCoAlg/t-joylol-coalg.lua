-- A Lua file

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/preamble.tex after line: 50

-- This is the lua code associated with t-joylol-coalg.mkiv

if not modules then modules = { } end modules ['t-joylol-coalg'] = {
    version   = 1.000,
    comment   = "joylol coalgegraic extensions - lua",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata         = thirddata        or {}
thirddata.joylol  = thirddata.joylol or {}

local joylol      = thirddata.joylol

thirddata.joylolCoAlgs = thirddata.joylolCoAlgs or {}
local coAlgs      = thirddata.joylolCoAlgs
coAlgs.theCoAlg   = {}
local theCoAlg    = coAlgs.theCoAlg

thirddata.literateProgs = thirddata.literateProgs or {}
local litProgs    = thirddata.literateProgs
litProgs.code     = litProgs.code or {}
local code        = litProgs.code
local setDefs     = litProgs.setDefs
local shouldExist = litProgs.shouldExist
local build       = setDefs(litProgs, 'build')

local contests    = setDefs(thirddata, 'contests')
local initStats   = contests.initStats
local tests       = setDefs(contests, 'tests')
                    setDefs(tests, 'suites')
                    setDefs(tests, 'failures')
local assert      = setDefs(contests, 'assert')
                    setDefs(contests, 'testRunners')
local expInfo     = setDefs(contests, 'expInfo')

                         setDefs(tests, 'stats')
tests.stats.joylol     = initStats()
local joylolStats      = tests.stats.joylol
local joylolAssertions = joylolStats.assertions

local tInsert = table.insert
local tConcat = table.concat
local tRemove = table.remove
local tSort   = table.sort
local sFmt    = string.format
local sMatch  = string.match
local toStr   = tostring
local mFloor  = math.floor
local lpPP    = litProgs.prettyPrint

--local pushData, pushProcess = joylol.pushData, joylol.pushProcess
--local pushProcessQuoted = joylol.pushProcessQuoted
--local popData, popProcess   = joylol.popData, joylol.popProcess
--local newList, newDictionary = joylol.newList, joylol.newDictionary
--local jEval = joylol.eval

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

interfaces.writestatus('joyLoLCoAlg', "loaded JoyLoL CoAlgs")

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 50

--local function newCoAlg(coAlgName)
--  local lCoAlg        = setDefs(theCoAlg, coAlgName)
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
end

coAlgs.newCoAlg = newCoAlg

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 100

local function createCoAlg()
end

coAlgs.createCoAlg = createCoAlg

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 150

local function addDependency(dependencyName)
  build.coAlgDependencies = build.coAlgDependencies or {}
  tInsert(build.coAlgDependencies, dependencyName)
end

coAlgs.addDependency = addDependency

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 200

local function newStackActionIn(aWord)
end

coAlgs.newStackActionIn = newStackActionIn

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 200

local function endStackActionIn()
end

coAlgs.endStackActionIn = endStackActionIn

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 250

local function newStackActionOut(aWord)
end

coAlgs.newStackActionOut = newStackActionOut

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 250

local function endStackActionOut()
end

coAlgs.endStackActionOut = endStackActionOut

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 250

local function addPreDataStackDescription(arg1, arg2)
end

coAlgs.addPreDataStackDescription = addPreDataStackDescription

local function addPostDataStackDescription(arg1, arg2)
end

coAlgs.addPostDataStackDescription = addPostDataStackDescription

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/codeManipulation.tex after line: 300

local function addPreProcessStackDescription(arg1, arg2)
end

coAlgs.addPreProcessStackDescription = addPreProcessStackDescription

local function addPostProcessStackDescription(arg1, arg2)
end

coAlgs.addPostProcessStackDescription = addPostProcessStackDescription

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylol.tex after line: 0

build.srcTypes = build.srcTypes or { }
build.srcTypes['JoylolCode'] = 'joylolCode'

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylol.tex after line: 0

local function markJoylolCodeOrigin()
  local codeType       = setDefs(code, 'JoylolCode')
  local codeStream     = setDefs(codeType, 'curCodeStream', 'default')
  codeStream           = setDefs(codeType, codeStream)
  return sFmt(';; from file: %s after line: %s',
    codeStream.fileName,
    toStr(
      mFloor(
        codeStream.startLine/code.lineModulus
      )*code.lineModulus
    )
  )
end

litProgs.markJoylolCodeOrigin = markJoylolCodeOrigin

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylol.tex after line: 50

local function addJoyLoLTargets(aCodeStream)
  litProgs.setCodeStream('Lmsfile', aCodeStream)
  litProgs.markCodeOrigin('Lmsfile')
  local lmsfile = {}
  tInsert(lmsfile, "require 'lms.joyLoL'\n")
  tInsert(lmsfile, "joylol.targets(lpTargets, {")
  tInsert(lmsfile, "  coAlgs = {")
  for i, aCoAlg in ipairs(build.coAlgsToBuild) do
    tInsert(lmsfile, "    '"..aCoAlg.."',")
  end
  tInsert(lmsfile, "  },")
 
  build.srcTargets = build.srcTargets or { }
  local srcTargets = build.srcTargets
 
  srcTargets.cHeader = srcTargets.cHeader or { }
  local cHeader      = srcTargets.cHeader
  tInsert(lmsfile, "  cHeaderFiles = {")
  for i, aSrcFile in ipairs(cHeader) do
    tInsert(lmsfile, "    '"..aSrcFile.."',")
  end
  tInsert(lmsfile, "  },")
 
  srcTargets.cCode = srcTargets.cCode or { }
  local cCode      = srcTargets.cCode
  tInsert(lmsfile, "  cCodeFiles = {")
  for i, aSrcFile in ipairs(cCode) do
    tInsert(lmsfile, "    '"..aSrcFile.."',")
  end
  tInsert(lmsfile, "  },")

  srcTargets.joylolCode = srcTargets.joylolCode or { }
  local joylolCode      = srcTargets.joylolCode
  tInsert(lmsfile, "  joylolCodeFiles = {")
  for i, aSrcFile in ipairs(joylolCode) do
    tInsert(lmsfile, "    '"..aSrcFile.."',")
  end
  tInsert(lmsfile, "  },")

  if build.cCodeLibDirs then
    tInsert(lmsfile, "  cCodeLibDirs = {")
    for i, aLibDir in ipairs(build.cCodeLibDirs) do
      tInsert(lmsfile, "    '"..aLibDir.."',")
    end
    tInsert(lmsfile, "  },")
  end
  if build.cCodeLibs then
    tInsert(lmsfile, "  cCodeLibs = {")
    for i, aLib in ipairs(build.cCodeLibs) do
      tInsert(lmsfile, "    '"..aLib.."',")
    end
    tInsert(lmsfile, "  },")
  end

  tInsert(lmsfile, "  coAlgLibs = {")
  for i, aCoAlgDependency in ipairs(build.coAlgDependencies) do
    tInsert(lmsfile, "    '"..aCoAlgDependency.."',")
  end
  tInsert(lmsfile, "  },")
  tInsert(lmsfile, "})")
  litProgs.setPrepend('Lmsfile', aCodeStream, true)
  litProgs.addCode.default('Lmsfile', tConcat(lmsfile, '\n'))
end

coAlgs.addJoyLoLTargets = addJoyLoLTargets

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylol.tex after line: 100

local function addCTestJoyLoLCallbacks(aCodeStream)
  local contests      = setDefs(thirddata, 'contests')
  local tests         = setDefs(contests, 'tests')
  local methods       = setDefs(tests, 'methods')
  local setup         = setDefs(methods, 'setup')
  local cTests        = setDefs(setup, 'cTests')
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
  setup               = setDefs(tests, 'setup')
  cTests              = setDefs(setup, 'cTests')
  cTests[aCodeStream] = cTests[aCodeStream] or { }
  tInsert(cTests[aCodeStream], [=[
setJoyLoLCallbackFrom(lstate, ctestsCallback);
]=])
end

coAlgs.addCTestJoyLoLCallbacks = addCTestJoyLoLCallbacks

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylol.tex after line: 200

function showStack(aMessage)
  texio.write_nl('-----------------------------------------------')
  if aMessage and type(aMessage) == 'string' and 0 < #aMessage then
    texio.write_nl(aMessage)
  end
  dataStack    = joylol.showData()
  processStack = joylol.showProcess()
  texio.write_nl("Data:")
  texio.write_nl(dataStack)
  texio.write_nl("Process:")
  texio.write_nl(processStack)
  texio.write_nl('AT: '..status.filename..'::'..status.linenumber)
  texio.write_nl('-----------------------------------------------')

end

contests.showStack = showStack

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylolTests.tex after line: 100

local function addJoylolTest(bufferName)
  local bufferContents = buffers.getcontent(bufferName):gsub("\13", "\n")
  local methods        = setDefs(tests, 'methods')
  local suite          = setDefs(tests, 'curSuite')
  local case           = setDefs(suite, 'curCase')
  local joylolTests    = setDefs(case,  'joylolTests')
  local curStage       = tests.stage:lower()
  if curStage:find('global') then
    if curStage:find('up') then
      local setup      = setDefs(tests,    'setup')
      joylolTests      = setDefs(setup,    'joylolTests')
    elseif curStage:find('down') then
      local teardown   = setDefs(tests,    'teardown')
      joylolTests      = setDefs(teardown, 'joylolTests')
    end
  elseif curStage:find('suite') then
    if curStage:find('up') then
      local setup      = setDefs(suite,    'setup')
      joylolTests      = setDefs(setup,    'joylolTests')
    elseif curStage:find('down') then
      local teardown   = setDefs(suite,    'teardown')
      joylolTests      = setDefs(teardown, 'joylolTests')
    end
  elseif curStage:find('method') then
    if curStage:find('up') then
      local setup      = setDefs(methods,  'setup')
      joylolTests      = setDefs(setup,    'joylolTests')
    elseif curStage:find('down') then
      local teardown   = setDefs(methods,  'teardown')
      joylolTests      = setDefs(teardown, 'joylolTests')
    end
  end
  tests.stage            = ''
  local joylolTestStream = setDefs(tests, 'curJoylolTestStream', 'default')
  joylolTestStream       = setDefs(joylolTests, joylolTestStream)
  tInsert(joylolTestStream, bufferContents)
end

contests.addJoylolTest = addJoylolTest

local function setJoylolTestStage(suiteCase, setupTeardown)
  tests.stage = suiteCase..'-'..setupTeardown
end

contests.setJoylolTestStage = setJoylolTestStage

local function setJoylolTestStream(aCodeStream)
  if type(aCodeStream) ~= 'string'
    or #aCodeStream < 1 then
    aCodeStream = 'default'
  end
  tests.curJoylolTestStream = aCodeStream
end

contests.setJoylolTestStream = setJoylolTestStream

local function addJoylolTestInclude(anInclude)
  local joylolIncludes   = setDefs(tests, 'joylolIncludes')
  local joylolTestStream = setDefs(tests, 'curJoylolTestStream', 'default')
  joylolTestStream       = setDefs(joylolIncludes, joylolTestStream)
  tInsert(joylolTestStream, anInclude)
end

contests.addJoylolTestInclude = addJoylolTestInclude

local function addJoylolTestLibDir(aLibDir)
  local joylolLibDirs    = setDefs(tests, 'joylolLibDirs')
  local joylolTestStream = setDefs(tests, 'curJoylolTestStream', 'default')
  joylolTestStream       = setDefs(joylolLibDirs, joylolTestStream)
  tInsert(joylolTestStream, aLibDir)
end

contests.addJoylolTestLibDir = addJoylolTestLibDir

local function addJoylolTestLib(aLib)
  local joylolLibs       = setDefs(tests, 'joylolLibs')
  local joylolTestStream = setDefs(tests, 'curJoylolTestStream', 'default')
  joylolTestStream       = setDefs(joylolLibs, joylolTestStream)
  tInsert(joylolTestStream, aLib)
end

contests.addJoylolTestLib = addJoylolTestLib

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylolTests.tex after line: 150

local function buildJoylolChunk(joylolChunk, curSuite, curCase)
  if type(joylolChunk) == 'table' then
    joylolChunk = tConcat(joylolChunk, '\n')
  end

  if type(joylolChunk) ~= 'string' then
    return nil
  end

  if joylolChunk:match('^%s*$') then
    return nil
  end

  return [=[
(
]=]..joylolChunk..[=[

)
(
 "]=]..curCase.desc..[=["
  ]=]..curCase.fileName..[=[

  ]=]..curCase.startLine..[=[

  ]=]..status.linenumber..[=[

)
runTestCase
showStack
true
]=]
end

contests.buildJoylolChunk = buildJoylolChunk

local function showJoylolTest()
  local curSuite = setDefs(tests, 'curSuite')
  local curCase  = setDefs(curSuite, 'curCase')
  texio.write_nl('===============================================')
  local joylolChunk =
    buildJoylolChunk(curCase.joylol, curSuite, curCase)
  if joylolChunk then
    texio.write_nl('Joylol Test: ')
    texio.write_nl('-----------------------------------------------')
    texio.write_nl(joylolChunk)
    texio.write_nl('-----------------------------------------------')
  else
    texio.write_nl('NO Joylol Test could be built')
  end
  texio.write_nl('AT: '..status.filename..'::'..status.linenumber)
  texio.write_nl('===============================================')
end

contests.showJoylolTest = showJoylolTest

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylolTests.tex after line: 200

local function runAJoylolTest(joylolTest, suite, case)
  case.passed = case.passed or true
  local joylolChunk = buildJoylolChunk(joylolTest, suite, case)
  if not joylolChunk then
    -- nothing to test
    return true
  end

  local caseStats = tests.stats.joylol.cases
  caseStats.attempted = caseStats.attempted + 1
  tex.print("\\starttyping")
  joylol.evalString(joylolChunk)
  tex.print("\\stoptyping")
  local testResult = joylol.popData()
  if not testResult then
    local errObj = joylol.popData()
    local failure = logFailure(
      "LuaTest FAILED",
      suite.desc,
      case.desc,
      errObj.message,
      toStr(errObj[1]),
      sFmt("in file: %s between lines %s and %s",
        case.fileName, toStr(case.startLine), toStr(case.lastLine))
      )
    reportFailure(failure, false)
    tInsert(tests.failures, failure)
    return false
  end

  -- all tests passed
  caseStats.passed = caseStats.passed + 1
  tex.print("\\noindent{\\green PASSED}")
  return true
end

contests.runAJoylolTest = runAJoylolTest

local function runCurJoylolTestCase(suite, case)
  runAJoylolTest(case.joylol, suite, case)
end

contests.testRunners.runCurJoylolTestCase = runCurJoylolTestCase

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylolTests.tex after line: 300

local function createJoylolTestFile(
  aCodeStream, aFilePath, aFileHeader
)
  texio.write("\n-------------------------------\n")
  texio.write("aCodeStream = ".. aCodeStream.."\n")
  texio.write("aFilePath   = ".. aFilePath.."\n")
  texio.write("\n-------------------------------\n")

  if not build.buildDir then
    texio.write('\nERROR: document directory NOT yet defined\n')
    texio.write('       NOT creating code file ['..aFilePath..']\n\n')
    return
  end

  if type(aFilePath) ~= 'string'
    or #aFilePath < 1 then
    texio.write('\nERROR: no file name provided for joylolTests\n\n')
    return
  end

  build.joylolTestTargets = build.joylolTestTargets or { }
  local aTestExec = aFilePath:gsub('%..+$','')
  tInsert(build.joylolTestTargets, aTestExec)

  aFilePath = build.buildDir .. '/buildDir/' .. aFilePath
  local outFile = io.open(aFilePath, 'w')
  if not outFile then
    return
  end
 
  texio.write('creating JoylolTest file: ['..aFilePath..']\n')
 
  if type(aFileHeader) == 'string'
    and 0 < #aFileHeader then
    outFile:write(aFileHeader)
    outFile:write('\n\n')
  end

  tests.suites = tests.suites or { }

  if type(aCodeStream) ~= 'string'
    or #aCodeStream < 1 then
    aCodeStream = 'default'
  end

  outFile:write(';; A JoylolTest file\n\n')
 
  outFile:write(';;-------------------------------------------------------\n')
  outFile:write(';; global setup\n')
  outFile:write(';;-------------------------------------------------------\n\n')
  local joylolIncludes = setDefs(tests, 'joylolIncludes')

  joylolIncludes[aCodeStream] = joylolIncludes[aCodeStream] or { }

  for i, anInclude in ipairs(joylolIncludes[aCodeStream]) do
    outFile:write(anInclude..'\n')
    outFile:write('load \n\n')
  end
  outFile:write('\n')

  tests.methods = tests.methods or { }
  local methods = tests.methods
  methods.setup = methods.setup or { }
  local mSetup  = methods.setup
  mSetup.joylolTests = mSetup.joylolTests or { }
  msJoylolTests      = mSetup.joylolTests

  --msJoylolTests[aCodeStream] = msJoylolTests[aCodeStream] or { }
 
  if msJoylolTests and
    msJoylolTests[aCodeStream] then
    local setupCode = tConcat(msJoylolTests[aCodeStream],'\n')
    setupCode       = litProgs.splitString(setupCode)
    outFile:write(tConcat(setupCode, '\n'))
    outFile:write('\n')
  end
  outFile:write('\n')

  outFile:write(';;-------------------------------------------------------\n')
  outFile:write(';; all tests\n')
  outFile:write(';;-------------------------------------------------------\n')

  outFile:write('(\n')
  outFile:write('  (\n')
  tests.setup = tests.setup or { }
  if tests.setup.joylolTests and
    tests.setup.joylolTests[aCodeStream] then
    local setupCode = tConcat(tests.setup.joylolTests[aCodeStream],'\n')
    setupCode       = litProgs.splitString(setupCode)
    outFile:write('  '..tConcat(setupCode, '\n  '))
    outFile:write('\n')
  end
  outFile:write('  ) ;; JoylolTests setup\n')
  outFile:write('  tests.defineTestsSetup\n\n')

  outFile:write('  (\n')
  tests.teardown = tests.teardown or { }
  if tests.teardown.joylolTests and
    tests.teardown.joylolTests[aCodeStream] then
    local teardownCode =tConcat(tests.teardown.joylolTests[aCodeStream],'\n  ')
    teardownCode = litProgs.splitString(teardownCode, '\n')
    outFile:write('  '..tConcat(teardownCode, '\n  '))
  end
  outFile:write('  ) ;; JoylolTests teardown\n')
  outFile:write('  tests.defineTestsTeardown\n\n')

  for i, aTestSuite in ipairs(tests.suites) do
    aTestSuite.cases = aTestSuite.cases or { }
    local suiteCaseBuf = { }

    for j, aTestCase in ipairs(aTestSuite.cases) do
      local joylolTests     = setDefs(aTestCase, 'joylolTests')
      if aTestCase.desc and
        aTestCase.fileName and
        aTestCase.startLine and
        aTestCase.lastLine and
        joylolTests[aCodeStream] then
        tInsert(suiteCaseBuf, '    ;;-------------------------------------------------------\n')
        tInsert(suiteCaseBuf, '    ;; jTC: '..aTestCase.desc..'\n')
        tInsert(suiteCaseBuf, '    ;;-------------------------------------------------------\n')
        tInsert(suiteCaseBuf, '    (\n')
        tInsert(suiteCaseBuf, '      (\n')
        tInsert(suiteCaseBuf, '        "'..aTestCase.desc..'"\n')
        tInsert(suiteCaseBuf, '        "'..aTestCase.fileName..'"\n')
        tInsert(suiteCaseBuf, '        '..toStr(aTestCase.startLine)..'\n')
        tInsert(suiteCaseBuf, '        '..toStr(aTestCase.lastLine)..'\n')
        tInsert(suiteCaseBuf, '      ) ;; test case details\n')
        tInsert(suiteCaseBuf, '      tests.recordTestCaseDetails\n\n')
        local joylolTestsCode = tConcat(joylolTests[aCodeStream], '\n')
        joylolTestsCode       = litProgs.splitString(joylolTestsCode)
        tInsert(suiteCaseBuf, '    '..tConcat(joylolTestsCode, '\n    '))
        tInsert(suiteCaseBuf, '\n    ) ;; test case\n')
        tInsert(suiteCaseBuf, '    tests.runTestCase\n\n')
      elseif (not aTestCase.desc or
        not aTestCase.fileName or
        not aTestCase.startLine or
        not aTestCase.lastLine) and
        joylolTests[aCodeStream] then
        texio.write("\nERROR missing \\startTestCase\n")
        texio.write("near:\n")
        texio.write(tConcat(joylolTests[aCodeStream], '\n'))
        texio.write('\n')
      end
    end

    if aTestSuite.desc and (0 < #suiteCaseBuf) then
      outFile:write('  ;;-------------------------------------------------------\n')
      outFile:write('  ;; jTS:'..aTestSuite.desc..'\n')
      outFile:write('  ;;-------------------------------------------------------\n')
      outFile:write('  (\n')
      outFile:write('    (\n')
      outFile:write('      "'..aTestSuite.desc..'"\n')
      outFile:write('    ) ;; test suite details\n')
      outFile:write('    tests.recordTestSuiteDetails\n\n')

      outFile:write('    (\n')
      aTestSuite.setup = aTestSuite.setup or { }
      if aTestSuite.setup.joylolTests and
        aTestSuite.setup.joylolTests[aCodeStream] then
        local setupCode = tConcat(aTestSuite.setup.joylolTests[aCodeStream],'\n  ')
        setupCode = litProgs.splitString(setupCode, '\n')
        outFile:write('    '..tConcat(setupCode, '\n    '))
      end
      outFile:write('    ) ;; test suite setup\n')
      outFile:write('    tests.defineTestSuiteSetup\n\n')

      outFile:write('    (\n')
      aTestSuite.teardown = aTestSuite.teardown or { }
      if aTestSuite.teardown.joylolTests and
        aTestSuite.teardown.joylolTests[aCodeStream] then
        local teardownCode = tConcat(aTestSuite.teardown.joylolTests[aCodeStream],'\n  ')
        teardownCode = litProgs.splitString(teardownCode, '\n')
        outFile:write('    '..tConcat(teardownCode, '\n    '))
      end
      outFile:write('    ) ;; test suite teardown\n')
      outFile:write('    tests.defineTestSuiteTeardown\n\n')

      outFile:write(tConcat(suiteCaseBuf))

      outFile:write('  )\n')
      outFile:write('  tests.runTestSuite\n\n')
 
    elseif not aTestSuite.desc and (0 < #suiteCaseBuf) then
      texio.write("\nERROR missing \\startTestSuite\n")
      texio.write("near:\n")
      texio.write(tConcat(suiteCaseBuf, '\n'))
      texio.write('\n')
    end
  end
 
  outFile:write(')\n')
  outFile:write('tests.runAllTests\n\n')

  outFile:write(';;-------------------------------------------------------\n')
  outFile:write(';; global teardown\n')
  outFile:write(';;-------------------------------------------------------\n\n')
 
  methods.teardown      = methods.teardown or { }
  local mTeardown       = methods.teardown
  mTeardown.joylolTests = mTeardown.joylolTests or { }
  mtJoylolTests         = mTeardown.joylolTests

  --mtJoylolTests[aCodeStream] = mtJoylolTests[aCodeStream] or { }

  if mtJoylolTests and
    mtJoylolTests[aCodeStream] then
    local teardownCode = tConcat(mtJoylolTests[aCodeStream],'\n')
    teardownCode       = litProgs.splitString(teardownCode)
    outFile:write('  '..tConcat(teardownCode, '\n  '))
    outFile:write('\n')
  end
  outFile:write('\n')
  outFile:write(';;-------------------------------------------------------\n')

  outFile:close()
end

contests.createJoylolTestFile = createJoylolTestFile

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/joylolTests.tex after line: 500

local function addJoylolTestTargets(aCodeStream)
  litProgs.setCodeStream('Lmsfile', aCodeStream)
  litProgs.markCodeOrigin('Lmsfile')
  local lmsfile = {}
  tInsert(lmsfile, "require 'lms.joylolTests'\n")
  tInsert(lmsfile, "joylolTests.targets(lpTargets, {")
  tInsert(lmsfile, "  testExecs = {")
  for i, aTestExec in ipairs(build.joylolTestTargets) do
    tInsert(lmsfile, "    '"..aTestExec.."',")
  end
  tInsert(lmsfile, "  },")
 
  build.srcTargets = build.srcTargets or { }
  local srcTargets = build.srcTargets
 
  srcTargets.cHeader = srcTargets.cHeader or { }
  local cHeader      = srcTargets.cHeader
  tInsert(lmsfile, "  cHeaderFiles = {")
  for i, aSrcFile in ipairs(cHeader) do
    tInsert(lmsfile, "    '"..aSrcFile.."',")
  end
  tInsert(lmsfile, "  },")
 
  srcTargets.cCode = srcTargets.cCode or { }
  local cCode      = srcTargets.cCode
  tInsert(lmsfile, "  cCodeFiles = {")
  for i, aSrcFile in ipairs(cCode) do
    tInsert(lmsfile, "    '"..aSrcFile.."',")
  end
  tInsert(lmsfile, "  },")

  if build.cCodeLibDirs then
    tInsert(lmsfile, "  cCodeLibDirs = {")
    for i, aLibDir in ipairs(build.cCodeLibDirs) do
      tInsert(lmsfile, "    '"..aLibDir.."',")
    end
    tInsert(lmsfile, "  },")
  end
  if build.cCodeLibs then
    tInsert(lmsfile, "  cCodeLibs = {")
    for i, aLib in ipairs(build.cCodeLibs) do
      tInsert(lmsfile, "    '"..aLib.."',")
    end
    tInsert(lmsfile, "  },")
  end

  tInsert(lmsfile, "  coAlgLibs = {")
  for i, aCoAlgDependency in ipairs(build.coAlgDependencies) do
    tInsert(lmsfile, "    '"..aCoAlgDependency.."',")
  end
  tInsert(lmsfile, "  },")
  tInsert(lmsfile, "})")
  litProgs.setPrepend('Lmsfile', aCodeStream, true)
  litProgs.addCode.default('Lmsfile', tConcat(lmsfile, '\n'))
end

coAlgs.addJoylolTestTargets = addJoylolTestTargets

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/rules.tex after line: 0

local function startRule(ruleName)
  texio.write_nl("starting rule: ["..ruleName.."]")
end

coAlgs.startRule = startRule

local sectionHeaders = tConcat({
  'arguments',
  'returns',
  'preDataStack',
  'preProcessStack',
  'preConditions',
  'postDataStack',
  'postProcessStack',
  'postConditions'
}, '|'):lower()

local function stopRule()
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
  texio.write_nl(lpPP(rules))
  texio.write_nl('---------rules-buffer-------------')
end


coAlgs.stopRule = stopRule

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/fragments.tex after line: 0

local function newFragment(fragmentName)
  local curFragment = setDefs(theCoAlg, 'curFragment')
  curFragment.name  = fragmentName
  setDefs(curFragment, 'code')
end

coAlgs.newFragment = newFragment

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/fragments.tex after line: 0

local function endFragment()
  local curFragment =
    shouldExist(theCoAlg, 'curFragment', {
      '\\stopJoyLoLFragment used outside of ',
      '\\startJoyLoLFragment environment'
    })
 
  texio.write_nl('---------joylol-fragment-------------')
  texio.write_nl(lpPP(curFragment))
  texio.write_nl('---------joylol-fragment-------------')

  local wordName =
    shouldExist(curFragment, 'name',
      'joylol fragment not named'
    )
  local codeVersions =
    shouldExist(curFragment, 'code',
      'incorrectly setup joylol fragment'
    )
 
  local numCodeVersions = 0
  for fragmentType, fragmentBody in pairs(codeVersions) do
--    joylol.crossCompilers.addFragment(
--      fragmentType,
--      wordName,
--      fragmentBody
--    )
    numCodeVersions = numCodeVersions + 1
  end
  if numCodeVersions < 1 then
    error(tConcat({
      'no \\startFragment environment used ',
      'inside a \\startJoyLoLFragment environment'
    }))
  end
end

coAlgs.endFragment = endFragment

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/fragments.tex after line: 50

local function startFragment(fragmentType)
  local curFragment =
    shouldExist(theCoAlg, 'curFragment', {
      '\\startFragment used outside of ',
      '\\startJoyLoLFragment environment'
    })
  curFragment.curType  = fragmentType
end

coAlgs.startFragment = startFragment

local function stopFragment()
  local curFragment  =
    shouldExist(theCoAlg, 'curFragment', {
      '\\stopFragment used outside of ',
      '\\startJoyLoLFragment environment'
    })
  local codeVersions =
    shouldExist(curFragment, 'code',
      'incorrectly setup joylol fragment - missing code'
    )
  local curType =
    shouldExist(curFragment, 'curType',
      'incorrectly setup fragment - missing curType'
    )
  local fragmentBody =
    buffers.getcontent('_fragment_buffer_'):gsub("\13", "\n")
  codeVersions[curType] = fragmentBody

  tex.sprint("\\starttyping")
  tex.print(fragmentBody)
  tex.sprint("\\stoptyping")
end

coAlgs.stopFragment = stopFragment

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/words.tex after line: 0

local function newWord(wordName)
  local curWord = setDefs(theCoAlg, 'curWord')
  curWord.name = wordName
  setDefs(curWord, 'code')
end

coAlgs.newWord = newWord

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/words.tex after line: 0

local function endWord()
  local curWord =
    shouldExist(theCoAlg, 'curWord', {
      '\\stopJoyLoLWord used outside of ',
      '\\startJoyLoLWord environment'
    })

  texio.write_nl('---------joylol-word-------------')
  texio.write_nl(lpPP(curWord))
  texio.write_nl('---------joylol-word-------------')

  local wordName =
    shouldExist(curWord, 'name',
      'joylol word not named'
    )
  local codeVersions =
    shouldExist(curWord, 'code',
      'incorrectly setup joylol word'
    )
 
  local numCodeVersions = 0
  for implType, implBody in pairs(codeVersions) do
--    joylol.crossCompilers.addImplementation(
--      implType,
--      wordName,
--      implBody
--    )
    numCodeVersions = numCodeVersions + 1
  end
  if numCodeVersions < 1 then
    error(tConcat({
      'no \\startImplementation environment used ',
      'inside a \\startJoyLoLWord environment'
    }))
  end
end

coAlgs.endWord = endWord

-- from file: /home/stg/ExpositionGit/tools/conTeXt/joylol/module/t-joylol-coalg/doc/context/third/joyLoLCoAlg/words.tex after line: 50

local function startImplementation(implType)
  local curWord =
    shouldExist(theCoAlg, 'curWord', {
      '\\startImplementation used outside of ',
      '\\startJoyLoLWord environment'
    })
  curWord.curType = implType
end

coAlgs.startImplementation = startImplementation

local function stopImplementation()
  local curWord =
    shouldExist(theCoAlg, 'curWord', {
      '\\stopImplementation used outside of ',
      '\\startJoyLoLWord environment'
    })
  local codeVersions =
    shouldExist(curWord, 'code',
      'incorrectly setup joylol word - missing code'
    )
  local curType =
    shouldExist(curWord, 'curType',
      'incorrectly setup joylol word - missing curType'
    )
  local implBody =
    buffers.getcontent('_implementation_buffer_'):gsub("\13", "\n")
  codeVersions[curType] = implBody

  tex.sprint("\\starttyping")
  tex.print(implBody)
  tex.sprint("\\stoptyping")
end

coAlgs.stopImplementation = stopImplementation