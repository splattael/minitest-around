require 'bundler/gem_tasks'
require 'rake/testtask'

desc "Run tests by default"
task :default => :test

desc "Run tests"
Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
  t.verbose = true
end
