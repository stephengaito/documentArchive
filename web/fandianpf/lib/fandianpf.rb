require 'padrino-core'
require 'fandianpf/persistentStore';
require 'fandianpf/contentTypes';

# The Fandianpf module provides the namespace for the whole FandianPF 
# system.
module Fandianpf
  extend Padrino::Module
  gem! "fandianpf"
end
