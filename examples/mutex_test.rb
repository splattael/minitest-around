require 'minitest/autorun'
require 'minitest/around'
require 'thread'

class MutexTest < Minitest::Test
  def around(&block)
    Mutex.new.synchronize(&block)
  end

  def test_synchronized
    # ...
  end
end

class PassArgsTest < Minitest::Test
  def around
    yield 1, 2
  end

  def test_passes_args(a, b)
    assert_equal 3, a + b
  end
end
