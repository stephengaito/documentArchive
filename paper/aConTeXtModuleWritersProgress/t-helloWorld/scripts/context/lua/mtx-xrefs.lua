if not modules then modules = { } end modules ['mtx-xrefs'] = {
    version   = 1.001,
    comment   = "companion to mtxrun.lua",
    author    = "Stephen Gaito, PerceptiSys Ltd",
    copyright = "Stephen Gaito, PerceptiSys Ltd",
    license   = "MIT License"
}

local helpinfo = [[
<?xml version="1.0"?>
<application>
 <metadata>
  <entry name="name">mtx-xrefs</entry>
  <entry name="detail">ConTeXt cross reference builder</entry>
  <entry name="version">0.10</entry>
 </metadata>
 <flags>
  <category name="basic">
   <subcategory>
    <flag name="build"><short>build cross references</short></flag>
    <flag name="check"><short>check ConTeXt interface files</short></flag>
    <flag name="verbose"><short>provide verbose narative of actions</short></flag>
   </subcategory>
  </category>
 </flags>
 <examples>
  <category>
   <title>Example</title>
   <subcategory>
    <example><command>mtxrun --script xrefs --build [xrefsHtmlDirectory]</command></example>
    <example><command>mtxrun --script xrefs --verbose --build [xrefsHtmlDirectory]</command></example>
    <example><command>mtxrun --script xrefs --check</command></example>
    <example><command>mtxrun --script xrefs --verbose --check</command></example>
   </subcategory>
   <subcategory>
    <example><command>The parameter xrefsHtmlDirectory is optional.</command></example>
    <example><command>If xrefsHtmlDirecotry is not provided it defaults</command></example>
    <example><command>to the top-level 'xrefs' subdirectory</command></example>
    <example><command>of the context installation.</command></example>
    <example><command>In either case the xrefsHtmlDirectory</command></example>
    <example><command>must allready exist and be writable by the user.</command></example>
   </subcategory>
  </category>
 </examples>
</application>
]]

local application = logs.application {
  name     = "mtx-xrefs",
  banner   = "ConTeXt cross reference builder 0.10",
  helpinfo = helpinfo,
}

local report = application.report
local lfs    = require('lfs')
local pp     = require('pl.pretty') -- for use while debugging

scripts               = scripts or { }
scripts.xrefs         = scripts.xrefs or { }
scripts.xrefs.verbose = false

dofile(resolvers.findfile('mtx-xrefs-html.lua'))

function scripts.xrefs.walkDirDoing(parentDir, subDir, parentFilesTable, filesMethod, dirMethod)
  parentFilesTable[subDir] = { }
  local curFilesTable = parentFilesTable[subDir]
  local curDir = parentDir..'/'..subDir
  if scripts.xrefs.verbose then report('walking ['..curDir..']') end
  local oldDir = lfs.currentdir()
  lfs.chdir(subDir)
  for aFile in lfs.dir('.') do
    if aFile:match('^%.+$') then
      -- ignore 
    elseif lfs.isfile(aFile) then
      if type(filesMethod) == 'function' then filesMethod(curFilesTable, curDir, aFile) end
    elseif lfs.isdir(aFile) then
      scripts.xrefs.walkDirDoing(curDir, aFile, curFilesTable, filesMethod, dirMethod)
      if type(dirMethod) == 'function' then dirMethod(curFileTable, curDir, aFile) end
    end
  end
  if next(curFilesTable) == nil then parentFilesTable[subDir] = nil end
  lfs.chdir(oldDir)
end

local function buildInterfaceSyntax(interfaceSyntax, someXml, curDir, aFile)
  if aFile:match('pe.xml$') then return end
  local tag = (someXml['ns'] or '')..':'..someXml['tg']
  interfaceSyntax[tag] = interfaceSyntax[tag] or { }
  local tagSyntax = interfaceSyntax[tag]
  local dt = someXml['dt']
  local foundChildren = false
  for i, value in ipairs(dt) do
    if type(value) == 'table' and value['special'] == nil then
      foundChildren = true
      buildInterfaceSyntax(tagSyntax, value, curDir, aFile)
    end
  end
  if not foundChildren then
    tagSyntax[aFile] = curDir
  end
  if someXml['at'] ~= nil then
    local at = someXml['at']
    local foundAttributes = false
    local atSyntax = tagSyntax['attributes'] or { }
    for key, value in pairs(at) do
      if key ~= nil and value ~= nil then
        foundAttributes = true
        atSyntax[key] = atSyntax[key] or { }
        atSyntax[key][value] = atSyntax[key][value] or { }
        atSyntax[key][value][aFile] = curDir
      end
    end
    if foundAttributes then
      tagSyntax['attributes'] = tagSyntax['attributes'] or { }
      tagSyntax['attributes'] = atSyntax
    end
  end
end

scripts.xrefs.definitionPatterns = { }

local function addPattern(patternName, pattern)
  scripts.xrefs.definitionPatterns[patternName] = { ['_pattern_'] = pattern }
end

addPattern('namespaces',            'namespace')
addPattern('loadsetups',            'loadsetups')
addPattern('macros',                'macros')
addPattern('setinterfaceconstants', 'setinterfaceconstant')
addPattern('setinterfacevariables', 'setinterfacevariable')
addPattern('setinterface', 'setinterface')
addPattern('dosingleempty', 'dosingleempty')
addPattern('dodoubleempty', 'dodoubleempty')
addPattern('iffirstargument', 'iffirstargument')
addPattern('ifsecondargument', 'ifsecondargument')
addPattern('singleexpandafter', 'singleexpandafter')
addPattern('doubleexpandafter', 'doubleexpandafter')

local function collectNameSpaces(definitionStr, curDir, aFile)
  local patterns = scripts.xrefs.definitionPatterns
  for patternName, patternsFound in pairs(patterns) do
    local aPattern = patternsFound['_pattern_']
    if aPattern then 
      if definitionStr:match(aPattern) then
        patternsFound[aFile] = curDir
      end
    end
  end
end

scripts.xrefs.authors = { }
local authors = scripts.xrefs.authors

local function addAuthor(definitionStr, curDir, aFile)
  if not aFile:match('%.lua') and not aFile:match('%.tex') and not curDir:match('test') then
    local authorName = definitionStr:match("author%s*=%s*([^,%]]+)[,%]]")
    if authorName then
      authorName = authorName:gsub('\\?%&', '&'):gsub('%/', '&'):gsub('%s+[Aa][Nn][Dd]%s+', '&')
      authorName = authorName:gsub('[%{%}%"]', ''):gsub("%'", '')
      authorName:gsub('([^%&]+)', function(c)
        local aName = c:gsub('^%s*', ''):gsub('%s*$','')
        local files = authors[aName] or { }
        files[aFile] = curDir
        authors[aName] = files
      end)
    end
  end
end

local function findInterfacesNamespaces(parentFilesTable, curDir, aFile)
  io.write('.')
  if aFile:match('%.xml$') then
    if scripts.xrefs.verbose then report('interface '..aFile) end
    local interfaceFile = io.open(aFile, 'r')
    local interfaceStr  = interfaceFile:read('*all')
    interfaceFile:close()
    if interfaceStr:match('%<cd%:interface') then
      -- we only care about interface definitions
      parentFilesTable[aFile] = curDir..'/'..aFile
      local interfaceXml  = xml.convert(interfaceStr)
      if interfaceXml['statistics']['errormessage'] ~= nil then
        report('non-valid xml in '..aFile)
      end
      buildInterfaceSyntax(scripts.xrefs.interfaceSyntax, interfaceXml, curDir, aFile)
    end
  elseif aFile:match('%.mkiv') or aFile:match('%.mkvi') or aFile:match('%.lua') or aFile:match('%.tex') then
    parentFilesTable[aFile] = curDir..'/'..aFile
    if scripts.xrefs.verbose then report('definition '..aFile) end
    local definitionFile = io.open(aFile, 'r')
    local definitionStr  = definitionFile:read('*all')
    definitionFile:close()
    --
    collectNameSpaces(definitionStr, curDir, aFile)
    addAuthor(definitionStr, curDir, aFile)
  end
end

local countDefs = 0
local function loadDefinitions(parentFilesTable, curDir, aFile)
  if aFile:match('%.mkiv$') or aFile:match('%.mkvi$') then
    countDefs = countDefs + 1
    report(aFile)
  end
end

local function loadExamples(parentFilesTable, curDir, aFile)
  if aFile:match('%.tex$') then
    report(aFile)
  end
end

local function setup()
  local contextDir = os.getenv('SELFAUTOPARENT')
  local subDir = contextDir:match('[^/]+$')
  contextDir = contextDir:gsub('/[^%/]+$', '')
  scripts.xrefs.contextDir = contextDir
  scripts.xrefs.subDir     = subDir
end

function scripts.xrefs.build()
  setup()
  --
  -- determine the htmlDir
  --
  local htmlDir    = environment.files[1]
  if htmlDir == nil then
    htmlDir = scripts.xrefs.contextDir..'/xrefs'
  end
  --
  -- prove that we can write into the htmlDir
  --
  local testFileName = htmlDir..'/mtx-xrefs-tmp-'..tostring(os.time())
  local testFile, errorStr = io.open(testFileName, 'w')
  if testFile then
    io.close(testFile)
    os.remove(testFileName)
  else
    if scripts.xrefs.verbose then report(errorStr) end
    report('You are not permitted to write into')
    report('  '..htmlDir)
    report('Please ensure this directory exists')
    report('and is writeable by you.\n')
    os.exit(-1)
  end
  scripts.xrefs.htmlDir = htmlDir
  report('Building xrefs into: ['..scripts.xrefs.htmlDir..']')
  --
  -- Now do the work
  --
  scripts.xrefs.files = { }
  scripts.xrefs.interfaceSyntax = { }
  lfs.chdir(scripts.xrefs.contextDir)
  --print('\nLooking for files: ')
  scripts.xrefs.walkDirDoing(
    '.', scripts.xrefs.subDir, scripts.xrefs.files,
    findInterfacesNamespaces, function() end)
  --print(pp.write(scripts.xrefs.interfaceSyntax))
  scripts.xrefs.interfaceSyntax = scripts.xrefs.interfaceSyntax[':@rt@']
  --print(pp.write(scripts.xrefs.files))
  --print(pp.write(scripts.xrefs.interfaceSyntax))
  --print(pp.write(scripts.xrefs.definitionPatterns))
  os.execute('rm -rf '..htmlDir..'/*')
  os.execute('ln -s ../../documents '..htmlDir..'/documents')
  scripts.xrefs.createFileHtml(htmlDir)
  scripts.xrefs.createInterfaceSyntaxHtml(htmlDir)
  scripts.xrefs.createPatternsHtml(htmlDir)
  scripts.xrefs.createAuthorsHtml(htmlDir)
  scripts.xrefs.createRootIndexHtml(htmlDir)
end

resolvers.load()

local function checkInterfaceSyntax(fixupTable, interfaceXml, curDir, aFile)
  for e in xml.collected(interfaceXml, 'cd:command') do
    if e.at['file'] then
      local aFileName = e.at['file']
      local aFilePath = resolvers.findfile(aFileName)
      if aFilePath and aFilePath ~= '' then
      else
        local aTestFileName = aFileName:gsub('%.[^%.]+$', '.mkiv')
        aFilePath = resolvers.findfile(aTestFileName)
        if aFilePath and aFilePath ~= '' then
          fixupTable[aFile] = fixupTable[aFile] or { }
          fixupTable[aFile]['dir'] = curDir
          fixupTable[aFile][aFileName] = fixupTable[aFile][aFileName] or { }
          fixupTable[aFile][aFileName]['file'] = aTestFileName
          fixupTable[aFile][aFileName]['path'] = aFilePath
        else
          local aTestFileName = aFileName:gsub('%.[^%.]+$', '.mkvi')
          aFilePath = resolvers.findfile(aTestFileName)
          if aFilePath and aFilePath ~= '' then
            fixupTable[aFile] = fixupTable[aFile] or { }
            fixupTable[aFile]['dir'] = curDir
            fixupTable[aFile][aFileName] = fixupTable[aFile][aFileName] or { }
            fixupTable[aFile][aFileName]['file'] = aTestFileName
            fixupTable[aFile][aFileName]['path'] = aFilePath
          else
            fixupTable[aFile] = fixupTable[aFile] or { }
            fixupTable[aFile]['dir'] = curDir
            fixupTable[aFile][aFileName] = fixupTable[aFile][aFileName] or { }
            fixupTable[aFile][aFileName]['file'] = 'Not found'
          end
        end
      end
    end
  end
end

local function checkInterfaces(fixupTable, curDir, aFile)
  io.write('.')
  if aFile:match('%.xml$') and not curDir:match('mkii') then
    if scripts.xrefs.verbose then report('interface '..aFile) end
    local interfaceFile = io.open(aFile, 'r')
    local interfaceStr  = interfaceFile:read('*all')
    interfaceFile:close()
    if interfaceStr:match('%<cd%:interface') then
      -- we only care about interface definitions
      local interfaceXml  = xml.convert(interfaceStr)
      if interfaceXml['statistics']['errormessage'] ~= nil then
        report('non-valid xml in '..aFile)
      end
      checkInterfaceSyntax(fixupTable, interfaceXml, curDir, aFile)
    end
  end
end

scripts.xrefs.interfacesNeedingFixes = { }

function scripts.xrefs.check()
  setup()
  lfs.chdir(scripts.xrefs.contextDir)
  --print('\nLooking for files: ')
  scripts.xrefs.walkDirDoing(
    '.', scripts.xrefs.subDir, scripts.xrefs.interfacesNeedingFixes,
    checkInterfaces, function() end)
  print(pp.write(scripts.xrefs.interfacesNeedingFixes))
end

if environment.argument("verbose") then
  scripts.xrefs.verbose = true
end

if environment.argument("build") then
  scripts.xrefs.build()
elseif environment.argument("check") then
  scripts.xrefs.check()
else
  application.help()
end

