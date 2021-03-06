# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'composite_rng/version'

Gem::Specification.new do |spec|
  spec.name          = "composite_rng"
  spec.version       = CompositeRng::VERSION
  spec.authors       = ["Peter Camilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]
  spec.description   = "A composable random number generator."
  spec.summary       = "A composable random number generation class."
  spec.homepage      = "http://teuthida-technologies.com/"
  spec.license       = "MIT"

  raw_list = `git ls-files`.split($/)
  raw_list = raw_list.keep_if {|entry| !entry.start_with?("docs") }

  spec.files         = raw_list
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", ">= 2.1.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency 'reek', "~> 1.3.8"
  spec.add_development_dependency 'minitest', "~> 5.8"
  spec.add_development_dependency 'rdoc', "~> 4.0.1"
end
