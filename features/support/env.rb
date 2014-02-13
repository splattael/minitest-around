require 'minitest/spec'

class MyWorld
  extend Minitest::Assertions

  attr_accessor :assertions

  def initialize
    self.assertions = 0
    @temp_pathes = {}
  end

  def write_test_file(filename, content)
    content = <<-RUBY + content
      require 'minitest/autorun'
      require "#{File.expand_path("../../../lib/minitest/around/spec", __FILE__)}"
    RUBY
    write_file(filename, content)
  end

  def write_file(filename, content)
    Tempfile.open(filename) do |file|
      file.write content
      assoc_tempfile filename, file.path
    end
  end

  def path_for(filename)
    @temp_pathes.fetch(filename)
  end

  private

  def assoc_tempfile(filename, temp_path)
    @temp_pathes[filename] = temp_path
  end
end

World do
  MyWorld.new
end
