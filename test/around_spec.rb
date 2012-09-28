require 'minitest/autorun'
require 'minitest/around'

describe "MiniTest Around" do
  describe "without around" do
    it "works w/o defining parameters" do
      assert true
    end
  end

  describe "without args" do
    around do |test|
      $before = true
      test.call
      $before = false
    end

    it "runs around" do
      $before.must_equal true
    end
  end

  describe "with single arg" do
    around { "string" }

    it "passes string argument" do |name|
      name.must_equal "string"
    end

    describe "nested" do
      it "string is still around" do |name|
        name.must_equal "string"
      end
    end

    describe "with multiple args" do
      around { [ 1, 2 ] }

      it "passes multiple args" do |a, b|
        a.must_equal 1
        b.must_equal 2
      end
    end
  end
end
