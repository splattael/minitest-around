require 'minitest/spec'

require 'minitest/around/version'
require 'minitest/around/unit'

module Minitest::Spec::DSL
  def around(&outer)
    define_method(:around) do |&inner|
      if outer.arity == 1
        outer.call(inner)
      else
        inner.call *outer.call
      end
    end
  end
end
