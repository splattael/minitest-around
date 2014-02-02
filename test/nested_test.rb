require_relative 'helper'
require 'minitest/around/unit'

$var = []

class OuterNestedTest < Minitest::Test
  def setup
    $var << :before
  end
  def teardown
    $var << :after
    $var.must_equal [:before, :ibefore, :begin, :ibegin, :during, :iend, :end, :iafter, :after]
  end
  def around
    $var << :begin
    yield
    $var << :end
  end
end

class InnerNestedTest < OuterNestedTest
  def setup
    $var << :ibefore
  end
  def teardown
    $var << :iafter
  end
  def around
    $var << :ibegin
    yield
    $var << :iend
  end
  def test_nesting
    $var << :during
  end
end
