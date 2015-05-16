# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/read_only/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-read_only"
  spec.version       = Rack::ReadOnly::VERSION
  spec.authors       = ["Jon Wood"]
  spec.email         = ["jon@blankpad.net"]

  spec.summary       = %q{Allows Rack based APIs to be set to read only.}
  spec.description   = File.read("README.md")
  spec.homepage      = "https://github.com/jellybob/rack-read_only"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "sinatra", "~> 1"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "rspec", "~> 3"
end
