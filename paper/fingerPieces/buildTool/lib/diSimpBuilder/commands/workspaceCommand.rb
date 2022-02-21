require 'readline'
require 'fileutils'

module DiSimpBuilder

  class WorkspaceCommand < Command
    def self.init_with_program(p)
      p.command(:workspace) do |c|
        c.syntax 'workspace'
        c.description 'Makes the current directory into a diSimp tool workspace'
        c.action do |args, options|
          begin
            FileUtils.mkdir_p 'languages'
          rescue Exception
            puts ""
          end
        end
      end
    end
  end

end

