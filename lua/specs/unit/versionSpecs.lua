-- A LunaTest specification file

-- We check that the version methods work

local joyLoL = require 'joyLoLC'

local lt = lunaTest

local versionSpecs = { }

function versionSpecs.test_cVersion()
  lt.assert_string(joyLoL.cVersion(), 'cVersion should be a string')
end

function versionSpecs.test_cGitVersion()
  local gitVersion = joyLoL.cGitVersion()
  lt.assert_table(gitVersion, 'cGitVersion should return a table')
  lt.assert_string(gitVersion.authorName)
  lt.assert_string(gitVersion.commitDate)
  lt.assert_string(gitVersion.commitShortHash)
  lt.assert_string(gitVersion.commitLongHash)
  lt.assert_string(gitVersion.subject)
  lt.assert_string(gitVersion.notes)
end

return versionSpecs