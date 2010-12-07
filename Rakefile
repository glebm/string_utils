require 'bundler'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'test/**/*_spec.rb'
end

Bundler::GemHelper.install_tasks
