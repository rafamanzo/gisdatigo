# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gisdatigo/version'

Gem::Specification.new do |spec|
  spec.name          = "gisdatigo"
  spec.version       = Gisdatigo::VERSION
  spec.authors       = ["Rafael Reggiani Manzo"]
  spec.email         = ["rr.manzo@gmail.com"]
  spec.license       = "LGPLv3"

  spec.summary       = %q{Automates most of the gem update process for Rails applications managed with bundler.}
  spec.description   = %q{Automates most of the gem update process for Rails applications managed with bundler. By producing updating them, running the tests and then commiting them.}
  spec.homepage      = "http://github.com/rafamanzo/gisdatigo"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "rugged"

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "mocha", "~> 1.5.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_bot", "~> 4.8.2"
  spec.add_development_dependency "codeclimate-test-reporter", '< 1.0.0'
end
