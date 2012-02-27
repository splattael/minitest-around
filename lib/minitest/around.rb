require 'minitest/unit'

module MiniTest
  module Around
    VERSION = "0.0.1"
  end
end

class MiniTest::Unit::TestCase
  def run_test(name)
    defined?(around) ? around { |*args| __send__(name, *args) } : __send__(name)
  end
end
