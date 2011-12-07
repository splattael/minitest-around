require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/around'

class TestWithoutAround < MiniTest::Unit::TestCase
  def test_no_around_defined
    assert true
  end
end

class TestWithAround < MiniTest::Unit::TestCase
  def run_test(name)
    p :here => name
    defined?(around) ? around { |*args| __send__(name, *args) } : __send__(name)
  end

  def around
    yield "string"
  end

  def test_around_passes_string(string)
    assert_equal "string", string
  end
end

class SpecWithAround < MiniTest::Spec
  describe "Without around" do
    it "works" do
      assert true
    end

    describe "with around" do
      def around
        yield "string"
      end

      it "works" do |name|
        assert_equal "string", name
      end
    end
  end
end
