require './lib/minitest/around/version'

Gem::Specification.new "minitest-around", Minitest::Around::VERSION do |s|
  s.authors     = ["Peter Suschlik"]
  s.email       = ["peter-minitest-around@suschlik.de"]
  s.homepage    = "https://github.com/splattael/minitest-around"
  s.summary     = "Around block for minitest."
  s.description = "Alternative for setup/teardown dance."
  s.license     = 'MIT'
  s.files       = `git ls-files`.split("\n")

  s.add_dependency 'minitest', '~> 5.0'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bump'
end
