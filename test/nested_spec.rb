require 'minitest/autorun'
require 'minitest/around'

$var = []

describe 'Outer' do
  before do
    $var << :before
  end
  after do
    $var << :after
    $var.must_equal [:before, :ibefore, :begin, :ibegin, :during, :iend, :end, :iafter, :after]
  end
  around do |test|
    $var << :begin
    test.yield
    $var << :end
  end

  describe 'Inner' do
    before do
      $var << :ibefore
    end
    after do
      $var << :iafter
    end
    around do |test|
      $var << :ibegin
      test.yield
      $var << :iend
    end
    it 'testing' do
      $var << :during
    end
  end
end
