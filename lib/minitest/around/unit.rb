require 'minitest/unit'

class Minitest::Test
  def send(name)
    if defined?(around) && name.start_with?('test')
      around { |*args| super(name, *args) }
    else
      super(name)
    end
  end
end
