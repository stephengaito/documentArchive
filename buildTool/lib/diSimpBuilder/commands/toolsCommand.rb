require 'readline'
require 'fileutils'
require 'ptools'
require 'open-uri'

module DiSimpBuilder

  class ToolsCommand < Command
    class << self
      def updateNpm
        puts "\nChecking for npm"
        if File.which('npm').nil? then
          puts "The npm command could not be found."
          puts "It is required for the use of the diSimpExplorer"
          puts "Please ensure both node.js and npm have been installed"
          exit(-1)
        else
          puts "Ensuring that npm is up to date"
          system("sudo npm install -g npm")
        end
      end

      def installGulp
       puts "\nChecking for gulp" 
       if File.which('gulp').nil? then
          puts "Ensuring that the global npm gulp command has been installed"
          system("sudo npm install -g gulp")
        else
          puts "Found gulp"
        end
      end

      def checkForDiSimpExplorer
        puts "\nChecking for the diSimpExplorer package"
        if File.directory?('racket') &&
           File.directory?('racket/pkgs') &&
           File.directory?('racket/pkgs/diSimpExplorer') then
          puts "Found diSimpExplorer"
        else
          puts "This project does not contain the diSimpExplorer"
          puts "Please change directories and try again"
          exit(-1)
        end
      end

      def installLocalNpmDependencies
        puts "\nInstalling local npm dependencies for the diSimpExplorer"
        FileUtils.mkdir_p('racket/pkgs/diSimpExplorer/vendor')
        Dir.chdir('racket/pkgs/diSimpExplorer/vendor') do
          system('npm install')
        end
      end

      def installZepto
        puts "\nInstalling a local copy of Zepto.js"
        Dir.chdir('racket/pkgs/diSimpExplorer/vendor') do
          open('zepto.zip', 'wb') do |file|
            file << open('https://github.com/madrobby/zepto/archive/master.zip').read
          end
          FileUtils.rm_rf('zepto')
          system('unzip zepto.zip')
          FileUtils.mv('zepto-master', 'zepto')
        end
      end

      def installBrowserArtefacts
        puts "\nInstalling all browser artefacts using gulp"
        Dir.chdir('racket/pkgs/diSimpExplorer/vendor') do
          system('gulp')
        end
      end

      def init_with_program(p)
        p.command(:tools) do |c|
          c.syntax 'tools'
          c.description 'Installs the diSimp (racket based) tools'
          c.action do |args, options|
            begin
              checkForDiSimpExplorer
              puts "\nYou may be asked for your sudo password"
              puts "to allow global commands to be installed: "
              updateNpm
              installGulp
              installLocalNpmDependencies
              installZepto
              installBrowserArtefacts
            rescue Exception
              puts "Sorry something failed"
            end
          end
        end
      end
    end
  end

end

