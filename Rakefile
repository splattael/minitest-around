require 'bundler/gem_tasks'

desc 'Default: run unit tests.'
task :default => :test

# Test
TEST_FILES = FileList.new('test/*_{test,spec}.rb')

desc "Run all tests"
task :test do
  TEST_FILES.each do |test_file|
    sh "bundle", "exec", "rake", "test:isolated", "TEST=#{test_file}"
  end
end

require 'rake/testtask'
Rake::TestTask.new(:"test:isolated") do |test|
  test.test_files = TEST_FILES
  test.libs << 'test'
  test.verbose = true
end

# RDoc
require 'rdoc/task'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'mintest-around'
  rdoc.main     = 'README.rdoc'
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE', 'lib/**/*.rb')
end

# Examples
EXAMPLES = FileList["examples/*.rb"]
desc "Run all examples"
task :"test:examples" do
  EXAMPLES.each do |example|
    sh "bundle", "exec", "ruby", example
  end
end
