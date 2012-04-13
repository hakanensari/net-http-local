# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'net/http'
require 'net/http/local/version'

Gem::Specification.new do |s|
  s.name        = 'net-http-local'
  s.version     = Net::HTTP::Local::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Hakan Ensari']
  s.email       = ['hakan.ensari@papercavalier.com']
  s.homepage    = 'http://github.com/hakanensari/net-http-local'
  s.summary     = %q{ Binds Net::HTTP requests to a local address and port }
  s.description = %q{ Net::HTTP::Local allows TCPSocket to bind Net::HTTP
                      requests to a local address and port. }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
