require "bundler/gem_tasks"
require "rspec/core/rake_task"

desc "Run spec tests"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["-c", "-f doc"]
end

task :default => [:spec]