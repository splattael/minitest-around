require 'minitest'

require 'minitest/around/version'
require 'minitest/around/unit'

class Minitest::Spec
  module DSL
    # - resume to call first part
    # - execute test
    # - resume fiber to execute last part
    def around(&block)
      fib = nil
      before do
        fib = Fiber.new { |context, resume| context.instance_exec(resume, &block) }
        fib.resume(self, lambda { Fiber.yield })
      end
      after  { fib.resume }
    end

    # Minitest does not support multiple before/after blocks
    def before(type=nil, &block)
      include Module.new { define_method(:setup) { super(); instance_exec(&block) } }
    end

    def after(type=nil, &block)
      include Module.new { define_method(:teardown) { instance_exec(&block); super() } }
    end
  end
end
