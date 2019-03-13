-- A Lua file

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapPreamble.tex after line: 50

-- This is the lua code associated with t-joylol-bootstrap.mkiv

if not modules then modules = { } end modules ['t-joylol-bootstrap'] = {
    version   = 1.000,
    comment   = "joylol bootstrap - lua",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "MIT License"
}

thirddata         = thirddata        or {}
thirddata.joylol  = thirddata.joylol or {}

local joylol      = thirddata.joylol

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

interfaces.writestatus('joylolBootstrap', "loaded JoyLoL bootstrap")

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 0

build.srcTypes = build.srcTypes or { }
build.srcTypes['JoylolCode'] = 'joylolCode'

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 0

local function markJoylolOrigin()
  local codeType       = setDefs(code, 'Joylol')
  local codeStream     = setDefs(codeType, 'curCodeStream', 'default')
  codeStream           = setDefs(codeType, codeStream)
  return sFmt('// from file: %s after line: %s',
    codeStream.fileName,
    toStr(
      mFloor(
        codeStream.startLine/code.lineModulus
      )*code.lineModulus
    )
  )
end

litProgs.markJoylolOrigin = markJoylolOrigin