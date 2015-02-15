require 'minitest/test'

require 'minitest/around/version'

Minitest::Test.class_eval do
  alias_method :run_without_around, :run
  def run(*args)
    if defined?(around)
      around { run_without_around(*args) }
    else
      run_without_around(*args)
    end
    self
  end
end
