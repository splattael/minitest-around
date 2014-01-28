require 'minitest/autorun'
require 'minitest/around'
require 'thread'

describe "Mutex" do
  around do |test|
    Mutex.new.synchronize(&test)
  end

  it "synchronized" do
    assert true
  end
end
