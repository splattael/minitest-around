require 'minitest/autorun'
require 'minitest/around/spec'

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
end
