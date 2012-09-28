require 'minitest/unit'

module MiniTest
  module Around
    VERSION = "0.0.1"
  end
end

class MiniTest::Unit::TestCase
  def run_test(name)
    if defined?(around)
      around { |*args| __send__(name, *args) }
    else
      __send__(name)
    end
  end
end

class MiniTest::Spec
  def self.around(&outer)
    define_method(:around) do |&inner|
      inner.call outer.call
    end
  end
end
