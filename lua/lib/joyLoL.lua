-- A Lua module

local joyLoL = require 'joyLoLC'

joyLoL.version = require 'version'

joyLoL.gitVersion = require 'gitVersion'

joyLoL.versionSummary = 
  joyLoL.version..' '..joyLoL.gitVersion.commitShortHash..' '..joyLoL.gitVersion.commitDate

joyLoL.cVersion = joyLoL.cVersion()
  
joyLoL.cGitVersion = joyLoL.cGitVersion()

joyLoL.cVersionSummary = 
  joyLoL.cVersion..' '..joyLoL.cGitVersion.commitShortHash..' '..joyLoL.cGitVersion.commitDate

return joyLoL