require 'minitest/autorun'
require 'minitest/around/spec'

describe "MiniTest Around" do
  describe "without around" do
    it "works w/o defining parameters" do
      assert true
    end
  end

  describe "simple" do
    around do |test|
      $before = true
      test.call
      $before = false
    end

    it "runs around" do
      $before.must_equal true
    end
  end

  describe "context" do
    before { @x = 1 }

    around do |test|
      @x = 2
      test.call
      assert_equal 2, @x
    end

    it "stays in context" do
      @x.must_equal 2
    end
  end

  describe "nested fun" do
    let(:list) { [] }
    before { list << 1 }
    before { list << 2 }
    after { list << 6 }
    around { |t| list << 3; t.call; list << 7 }
    before { list << 4 }
    around { |t| list << 5; t.call; list << 8 }
    after { list << 9 }
    after do
      if @xxx == 1
        list.must_equal [1, 2, 3, 4, 5, 6, 7, 8, 9]
      elsif @xxx == 2
        list.must_equal [1, 2, 3, 4, 5, 51, 6, 7, 8, 9]
      else
        raise
      end
    end

    it "orders" do
      @xxx = 1
      list.must_equal [1, 2, 3, 4, 5]
    end

    describe "more nesting fun" do
      before { list << 51 }

      it "orders" do
        @xxx = 2
        list.must_equal [1, 2, 3, 4, 5, 51]
      end
    end
  end
end
