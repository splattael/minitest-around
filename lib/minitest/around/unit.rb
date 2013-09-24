require 'minitest/unit'
require 'minitest/around/version'

class MiniTest::Unit::TestCase
  def run_test(name)
    if defined?(around)
      around { |*args| __send__(name, *args) }
    else
      __send__(name)
    end
  end
end
