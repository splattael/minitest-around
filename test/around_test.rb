require 'minitest/autorun'
require 'minitest/around'

class TestWithoutAround < MiniTest::Unit::TestCase
  def test_no_around_defined
    assert true
  end
end

class TestWithoutArgs < MiniTest::Unit::TestCase
  def around
    $before = true
    yield
    $before = false # hard to test?
  end

  def test_runs_around
    assert_equal true, $before
  end
end

class TestWithSingleArg < MiniTest::Unit::TestCase
  def around
    yield "string"
  end

  def test_around_passes_string(string)
    assert_equal "string", string
  end
end

class TestWithMultipleArgs < MiniTest::Unit::TestCase
  def around
    yield 1, 2
  end

  def test_passes_multiple_args(a, b)
    assert_equal 1, a
    assert_equal 2, b
  end
end

class SpecWithAround < MiniTest::Spec
end
