require './lib/minitest/around/version'

Gem::Specification.new "minitest-around", MinitestAround::VERSION do |s|
  s.authors     = ["Peter Leitzen"]
  s.email       = ["peter-minitest-around@suschlik.de"]
  s.homepage    = "https://github.com/splattael/minitest-around"
  s.summary     = "Around block for minitest."
  s.description = "Alternative for setup/teardown dance."
  s.license     = 'MIT'
  s.files       = `git ls-files lib LICENSE README.md`.split("\n")

  s.add_dependency 'minitest', '> 5.0', '< 7.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'bump'
end
