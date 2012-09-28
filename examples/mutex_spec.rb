require 'minitest/autorun'
require 'minitest/around'
require 'thread'

describe "Mutex" do
  around do |test|
    Mutex.new.synchronize(&test)
  end

  it "synchronized" do
    # ...
  end

  describe "pass args" do
    around do
      # No block arg "test",
      [ 1, 2 ]
    end

    it "passes args" do |a, b|
      (a + b).must_equal 3
    end
  end
end
