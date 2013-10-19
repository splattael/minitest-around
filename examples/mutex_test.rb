require 'minitest/autorun'
require 'minitest/around'
require 'thread'

class MutexTest < MiniTest::Unit::TestCase
  def around(&block)
    Mutex.new.synchronize(&block)
  end

  def test_synchronized
    # ...
  end
end
