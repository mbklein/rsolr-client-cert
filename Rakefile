require "bundler/gem_tasks"
require "rspec/core/rake_task"

desc "Run spec tests"
task :spec do
  RSpec::Core::RakeTask.new(:core) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rspec_opts = ['--backtrace']
  end
end