require 'bundler/setup'
require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'bump/tasks'

desc 'Default: run unit tests.'
task default: ["test", "features"]

# Test
desc "Run all tests"
task :test do
  sh "forking-test-runner test/ --quiet"
end

desc "Run all examples"
task "test:examples" do
  FileList["examples/*.rb"].each do |example|
    sh "ruby", example
  end
end

# features
Cucumber::Rake::Task.new(:features) do |t|
  # TODO: fix these tags
  skip_tags = %w[rspec todo].map { |tag| "--tag 'not @#{tag}'" }.join(" ")
  t.cucumber_opts = ["features", skip_tags, "--publish-quiet"]
end

desc "bundle all gemfiles/ CMD=install"
task :bundle do
  extra = ENV["CMD"] || "install"
  Bundler.with_original_env do
    Dir["{gemfiles/*.gemfile,Gemfile}"].reverse.each { |gemfile| sh "BUNDLE_GEMFILE=#{gemfile} bundle #{extra}" }
  end
end
