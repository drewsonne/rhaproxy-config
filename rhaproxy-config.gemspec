# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rhaproxy/config/version'

Gem::Specification.new do |spec|
  spec.name          = "rhaproxy-config"
  spec.version       = Rhaproxy::Config::VERSION
  spec.authors       = ["Drew J. Sonne"]
  spec.email         = ["drew.sonne@gmail.com"]
  spec.summary       = 'Exposes an API to allow dynamic modification of the haproxy config'
  spec.description   = 'TCP server which listens for commands to execute which will modify the haproxy config file and reload it.'
  spec.homepage      = 'https://github.com/drewsonne/rhaproxy-config'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'eventmachine'
  spec.add_runtime_dependency 'trollop', '~> 2.1'
  spec.add_runtime_dependency 'haproxy-tools', '~> 0.3'

end
