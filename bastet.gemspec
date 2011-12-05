# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bastet/version"

Gem::Specification.new do |s|
  s.name        = "bastet"
  s.version     = Bastet::VERSION
  s.authors     = ["Duncan Grazier"]
  s.email       = ["itsmeduncan@gmail.com"]
  s.homepage    = "https://github.com/itsmeduncan/bastet"
  s.summary     = %q{Simple feature rollout for criteria based groups}
  s.description = %q{Simple feature rollout for criteria based groups}

  s.rubyforge_project = "bastet"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake", "~> 0.9.2.2"
  s.add_development_dependency "rspec", "~> 2.7.0"
  s.add_development_dependency "mocha", "~> 0.10.0"
  s.add_development_dependency "redis", "~> 2.2.2"
  s.add_development_dependency "simplecov"
end
