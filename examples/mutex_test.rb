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

class PassArgsTest < MiniTest::Unit::TestCase
  def around
    yield 1, 2
  end

  def test_passes_args(a, b)
    assert_equal 3, a + b
  end
end
