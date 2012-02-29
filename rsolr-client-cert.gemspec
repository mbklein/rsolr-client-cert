# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rsolr/client_cert/version"

Gem::Specification.new do |s|
  s.name        = "rsolr-client-cert"
  s.version     = RSolr::ClientCert::VERSION
  s.authors     = ["Michael Klein"]
  s.email       = ["mbklein@gmail.com"]
  s.homepage    = "https://github.com/mbklein/rsolr-client-cert"
  s.summary     = %q{Client certificate authentication for RSolr}
  s.description = %q{Client certificate authentication for RSolr}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_runtime_dependency "jruby-openssl" if RUBY_PLATFORM == 'java'
  s.add_runtime_dependency "rsolr"
  s.add_runtime_dependency "rest-client"
end
