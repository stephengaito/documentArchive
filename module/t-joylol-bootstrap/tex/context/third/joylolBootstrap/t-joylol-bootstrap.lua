-- A Lua file

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapPreamble.tex after line: 50

-- Copyright 2019 PerceptiSys Ltd (Stephen Gaito)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an "AS
-- IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
-- express or implied. See the License for the specific language
-- governing permissions and limitations under the License. end

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapPreamble.tex after line: 0

-- This is the lua code associated with t-joylol-bootstrap.mkiv

if not modules then modules = { } end modules ['t-joylol-bootstrap'] = {
    version   = 1.000,
    comment   = "joylol bootstrap - lua",
    author    = "PerceptiSys Ltd (Stephen Gaito)",
    copyright = "PerceptiSys Ltd (Stephen Gaito)",
    license   = "Apache License"
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
build.srcTypes['Joylol'] = 'joylol'

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

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 50

local P, R, S, V, C, Cc, Cg, Ct =
  lpeg.P, lpeg.R, lpeg.S, lpeg.V, lpeg.C, lpeg.Cc, lpeg.Cg, lpeg.Ct
local lMatch = lpeg.match

local currentCoAlg = "unknown"
local coAlgTable   = {}

local function extractCoAlg(aMatch)
  currentCoAlg       = aMatch
  coAlgTable[aMatch] = {}
end

local function extractInherit(aMatch)
  coAlgTable[currentCoAlg] = coAlgTable[currentCoAlg] or {}
 
  coAlgTable[currentCoAlg]['parents'] =
    coAlgTable[currentCoAlg]['parents'] or {}
  tInsert(coAlgTable[currentCoAlg]['parents'], aMatch)
 
  coAlgTable[aMatch] = coAlgTable[aMatch] or { }
 
  coAlgTable[aMatch]['children'] =
    coAlgTable[aMatch]['children'] or {}
  tInsert(coAlgTable[aMatch]['children'], currentCoAlg)
end

local function extractParser(anId, aParser)
  coAlgTable[anId] = coAlgTable[anId] or {}
 
  coAlgTable[anId]['parser'] = aParser
end

local function buildParserStream(parserStream)
  local coAlgNames = { }
  for aCoAlg, aBody in pairs(coAlgTable) do
    tInsert(coAlgNames, aCoAlg)
    if aBody['children'] then
      local choiceBody = {}
      for i, aChild in ipairs(aBody['children']) do
        tInsert(choiceBody, "parse"..aChild)
      end
      aBody['parser'] = "( "..tConcat(choiceBody, '\n').." ) choice"
    end
  end
 
  tSort(coAlgNames)
 
  for i, aCoAlg in ipairs(coAlgNames) do
    local aBody   = coAlgTable[aCoAlg]
    local aParser = "( "..aBody['parser'].." ) \"parse"..aCoAlg.."\" define"
    tInsert(parserStream, aParser)
  end
end

local function extractConcreteParserFromTo(fromCodeStreamName, toCodeStreamName)
  local codeType       = setDefs(code, 'Joylol')
  fromCodeStreamName   = fromCodeStreamName or 'default'
  toCodeStreamName     = toCodeStreamName   or 'parser'
  local fromCodeStream = setDefs(codeType, fromCodeStreamName)
  local toCodeStream   = setDefs(codeType, toCodeStreamName)

  local ws       = S('\r\n\f\t ')^1
  local id       = R('AZ', 'az') * (R('AZ', 'az', '09') + S('_-'))^0

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 100

  local coAlg =
    ( P('CoAlgebra') * ws * C(id) ) / extractCoAlg

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 100

  local inherit  =
    ( P('inherit') * ws * C(id) * ws * P(';') ) / extractInherit

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 150

  local concreteParser   = (
    P('feature') * ws * P('--') * ws *
    P('Concrete') * ws * P('Syntax') * ws *
    P('parse') * C(id) *
    ( 1 - P('beginSExp') )^1 *  P('beginSExp') *
    C( ( 1 - P('endSExp') )^1 ) * P('endSExp')
    ) / extractParser

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 150

  local parts    = coAlg + inherit + concreteParser
  local matchPat = Ct( P{ parts + 1 * lpeg.V(1) }^0 )
  lMatch(matchPat, tConcat(fromCodeStream, '\n\n'))

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapCode.tex after line: 150

  tInsert(codeType[toCodeStreamName],
    "// START of automatically generated jPEG parser")
  tInsert(codeType[toCodeStreamName],
    "// listed alphabetically by definition")
  buildParserStream(codeType[toCodeStreamName])
  tInsert(codeType[toCodeStreamName],
    "// END of automatically generated jPEG parser")
 
--  texio.write_nl(">>>>>>>>>>EXTRACT>>>>>>>>>>")
--  texio.write_nl("from code stream: ["..fromCodeStreamName.."]")
--  texio.write_nl(lpPP(fromCodeStream))
--  texio.write_nl(">>>>>>>>>>EXTRACT<<<<<<<<<<")
--  texio.write_nl("to code stream: [coAlgTable]")
--  texio.write_nl(lpPP(coAlgTable))
--  texio.write_nl(">>>>>>>>>>EXTRACT<<<<<<<<<<")
--  texio.write_nl("to code stream: ["..toCodeStreamName.."]")
--  texio.write_nl(lpPP(toCodeStream))
--  texio.write_nl("<<<<<<<<<<EXTRACT<<<<<<<<<<\n")
--  texio.write_nl(lpPP(codeType))
--  texio.write_nl("<<<<<<<<<<EXTRACT<<<<<<<<<<\n")
end

litProgs.extractConcreteParserFromTo = extractConcreteParserFromTo

-- from file: /home/stg/ExpositionGit/tools/conTeXt/protoJoylol/module/t-joylol-bootstrap/doc/context/third/joylolBootstrap/joylolBootstrapConclusions.tex after line: 0

-- Copyright 2019 PerceptiSys Ltd (Stephen Gaito)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an "AS
-- IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
-- express or implied. See the License for the specific language
-- governing permissions and limitations under the License. end