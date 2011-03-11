# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "multiplex/version"

Gem::Specification.new do |s|
  s.name        = "multiplex"
  s.version     = Multiplex::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paper Cavalier"]
  s.email       = ["code@papercavalier.com"]
  s.homepage    = "http://rubygems.org/gems/multiplex"
  s.summary     = %q{Bind Net::HTTP requests to non-default local IPs.}
  s.description = %q{Multiplex lets you bind Net::HTTP requests to non-default local IP addresses.}

  s.rubyforge_project = "multiplex"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
