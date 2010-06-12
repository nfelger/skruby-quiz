require 'open3'

Given /^the following word list:$/ do |table|
  @input = table.raw.join("\n")
end

When /^I run 'make_anagrams'$/ do
  make_anagrams = File.expand_path(File.dirname(__FILE__) + '/../../bin/make_anagrams')
  Open3.popen3('ruby ' + make_anagrams) do |stdin, stdout, stderr|
    stdin << @input
    stdin.close
    @output = stdout.read
    errors = stderr.read
    raise errors unless errors == ''
  end
end

Then /^the output should be:$/ do |table|
  @output.should == table.raw.join("\n") + "\n"
end