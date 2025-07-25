# frozen_string_literal: true

require "dotenv/tasks"
require "rake/testtask"
require "rubocop/rake_task"

task default: %w[def]

RuboCop::RakeTask.new

namespace :test do
  Rake::TestTask.new do |t|
    t.name = "unit"
    t.description = "Run unit tests"
    t.libs << "test"
    t.test_files = FileList["test/unit/*.rb"]
    t.verbose = true
    t.warning = true
    t.deps = [:rubocop]
  end

  Rake::TestTask.new do |t|
    t.name = "integration"
    t.description = "Run integration tests (put credentials in a .env file)"
    t.libs << "test"
    t.test_files = FileList["test/integration/*.rb"]
    t.verbose = true
    t.warning = true
    t.deps = %i[dotenv rubocop]
  end

  Rake::TestTask.new do |t|
    t.name = "examples"
    t.description = "Run example tests (put credentials in a .env file)"
    t.libs << "test"
    t.test_files = FileList["test/examples/*.rb"]
    t.verbose = true
    t.warning = true
    t.deps = %i[dotenv rubocop]
  end
end

desc "Run unit & integration tests"
task :test do
  Rake::Task["test:unit"].invoke
  Rake::Task["test:integration"].invoke
end

desc "Run tests and generate a code coverage report"
task :coverage do
  ENV["COVERAGE"] = "true" if ENV["GITHUB_ACTIONS"] || ENV["CI"].nil?
  Rake::Task["test"].execute
end

task def: %i[coverage] do
end
