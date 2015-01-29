# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aescrypt/version'

Gem::Specification.new do |spec|
  spec.name          = "aescrypt"
  spec.version       = Aescrypt::VERSION
  spec.authors       = ["David Workman"]
  spec.email         = ["workmad3@gmail.com"]
  spec.summary       = %q{Wrapper around the aescrypt tool for generating encrypted files}
  spec.description   = %q{Provides a simple ruby wrapper around the command-line AEScrypt tool available from https://www.aescrypt.com/

  This gem also compiles version 3.0.9 of AEScrypt as part of the bundle and uses that bundled
  version for performing all actions}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
