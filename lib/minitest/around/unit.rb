require 'minitest/test'

require 'minitest/around/version'

Minitest::Test.prepend(Module.new do
  def run(*args)
    if defined?(around)
      result = nil
      around { result = super(*args) }
      result
    else
      super(*args)
    end
  end
end)
