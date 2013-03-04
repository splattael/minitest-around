require 'minitest/spec'

class MiniTest::Spec
  def self.around(&outer)
    define_method(:around) do |&inner|
      if outer.arity == 1
        outer.call(inner)
      else
        inner.call *outer.call
      end
    end
  end
end
