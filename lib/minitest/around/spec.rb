require 'minitest/spec'

require 'minitest/around/version'
require 'minitest/around/unit'

class MiniTest::Spec
  module DSL
    def around(&outer)
      define_method(:around) do |&inner|
        if outer.arity == 1
          if defined?(super)
            super() { outer.call(inner) }
          else
            outer.call(inner)
          end
        else
          inner.call *outer.call
        end
      end
    end
  end
end
