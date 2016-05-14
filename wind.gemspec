# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wind/version'

Gem::Specification.new do |spec|
  spec.name          = "wind"
  spec.version       = Wind::VERSION
  spec.authors       = ["Ryan Moore"]
  spec.email         = ["moorer@udel.edu"]

  spec.summary       = %q{Buffered each_line and other nifty tools.}
  spec.description   = %q{My personal Ruby core extensions including a super fast buffered version of each_line.}
  spec.homepage      = "https://github.com/mooreryan/wind"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.6", ">= 4.6.4"
  spec.add_development_dependency "yard", "~> 0.8.7.6"
  spec.add_development_dependency "coveralls", "~> 0.8.11"
end
