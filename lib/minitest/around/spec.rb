require 'minitest/spec'

require 'minitest/around/version'
require 'minitest/around/unit'

class MiniTest::Spec
  module DSL
    def around(&outer)
      define_method(:around) do |&inner|
        super() { outer.call(inner) }
      end
    end
  end
end
