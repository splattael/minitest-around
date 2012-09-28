require 'minitest/autorun'
require 'minitest/around'

class TestWithoutAround < MiniTest::Unit::TestCase
  def test_no_around_defined
    assert true
  end
end

class TestWithAround < MiniTest::Unit::TestCase
  def around
    yield "string"
  end

  def test_around_passes_string(string)
    assert_equal "string", string
  end
end

class SpecWithAround < MiniTest::Spec
  describe "Without around" do
    it "works w/o defining parameters" do
      assert true
    end
  end

  describe "with around" do
    def around
      yield "string"
    end

    it "passes string argument" do |name|
      assert_equal "string", name
    end

    describe "nested" do
      it "string still around" do |name|
        assert_equal "string", name
      end
    end
  end
end
