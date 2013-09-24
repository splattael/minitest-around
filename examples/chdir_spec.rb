require 'minitest/autorun'
require 'minitest/around/spec'
require 'tmpdir'

describe "inside new directory" do
  around do |test|
    Dir.mktmpdir do |dir|
      $dir = dir
      Dir.chdir(dir) do
        test.call
      end
    end
  end

  it "is in new directory" do
    assert_equal $dir, Dir.pwd
  end
end
