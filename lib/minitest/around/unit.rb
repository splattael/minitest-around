require 'minitest/unit'
require 'minitest/around/version'

class MiniTest::Unit::TestCase
  def run_test(name)
    around { |*args| __send__(name, *args) }
  end

  def around(*args)
    yield *args
  end
end
