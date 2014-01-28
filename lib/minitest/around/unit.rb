require 'minitest/unit'
require 'minitest/around/version'

class MiniTest::Unit::TestCase
  def run_test(name)
    around { __send__(name) }
  end

  def around
    yield
  end
end
