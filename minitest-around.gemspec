# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minitest/around"

Gem::Specification.new do |s|
  s.name        = "minitest-around"
  s.version     = MiniTest::Around::VERSION
  s.authors     = ["Peter Suschlik"]
  s.email       = ["peter-minitest-around@suschlik.de"]
  s.homepage    = ""
  s.summary     = %q{Around block for minitest.}
  s.description = %q{Alternative for setup/teardown dance.}

  s.rubyforge_project = "minitest-around"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency  "minitest"
  s.add_runtime_dependency      "minitest"
end
