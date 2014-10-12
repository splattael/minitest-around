require 'minitest'

require 'minitest/around/version'
require 'minitest/around/unit'

Minitest::Spec::DSL.class_eval do
  # - resume to call first part
  # - execute test
  # - resume fiber to execute last part
  def around(&block)
    fib = nil
    before do
      fib = Fiber.new do |context, resume|
        begin
          context.instance_exec(resume, &block)
        rescue Object
          fib = :failed
          raise
        end
      end
      fib.resume(self, lambda { Fiber.yield })
    end
    after  { fib.resume unless fib == :failed }
  end

  # Minitest does not support multiple before/after blocks
  def before(type=nil, &block)
    include Module.new { define_method(:setup) { super(); instance_exec(&block) } }
  end

  def after(type=nil, &block)
    include Module.new { define_method(:teardown) { instance_exec(&block); super() } }
  end
end
