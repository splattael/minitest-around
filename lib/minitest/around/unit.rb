require 'minitest'
require 'minitest/around/version'

class Minitest::Test
  alias_method :run_without_around, :run
  def run(*args)
    if defined?(around)
      around { run_without_around(*args) }
    else
      run_without_around(*args)
    end
    self
  end
end
