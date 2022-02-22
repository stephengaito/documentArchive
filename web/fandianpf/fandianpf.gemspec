# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fandianpf/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Stephen Gaito"]
  gem.email         = ["stephen@perceptisys.co.uk"]
  gem.description   = %q{
FandianPF Scientific Publishing Framework, a Padrino gem.

"Fandian" is old anglo-saxon for “To try, tempt, prove, examine, explore, seek, search out” which is the essence of what the Scientific method is all about.

One of the most important activities of a Scientist, is participating in the on going discussion surrounding their particular scientific discoveries.

The FandianPF scientific publishing framework is a collection of tools designed to make this on-going discussion more fruitful for a wider audience.
}
  gem.summary       = %q{
FandianPF Scientific Publishing Framework, a Padrino gem, designed to make participating in scientific discussion more fruitful for a wider audience.
}
  gem.homepage      = "https://github.com/fandianpf/fandianpf"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fandianpf"
  gem.require_paths = ["lib", "app"]
  gem.version       = Fandianpf::VERSION

#  gem.add_dependency "padrino-core"
end
