require 'tempfile'

Given(/^a file named "(.*?)" with:$/) do |filename, content|
  write_test_file(filename, content)
end

When(/^I run `rspec (.*?)`$/) do |filename|
  path = path_for(filename)
  @output = `ruby #{path}`
end

Then(/^the output should contain:$/) do |content|
  assert_includes @output, content
end

Then(/^the output should contain "(.*?)"$/) do |content|
  assert_includes @output, content
end
