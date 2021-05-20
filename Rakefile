# frozen_string_literal: true

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see
  # http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'sovren-rest'
  gem.homepage = 'https://github.com/topechelon/sovren-rest'
  gem.license = 'MIT'
  gem.summary = %(Sovren 9.0 Rest)
  gem.description = %(Interfaces with the Sovren 9.0 REST API)
  gem.email = 'devs@topechelon.com'
  gem.authors = ['TEN Devs V3']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

namespace :rspec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test) do |test|
    test.pattern = 'spec/unit/**/*_spec.rb'
    test.rspec_opts = '--color --require spec_helper --format documentation'
  end

  RSpec::Core::RakeTask.new(:integration) do |test|
    test.pattern = 'spec/integration/**/*_spec.rb'
    test.rspec_opts = '--color --require spec_helper --format documentation'
  end

  RSpec::Core::RakeTask.new(:regression) do |test|
    test.pattern = 'spec/unit/**/*_spec.rb'
    test.rspec_opts = '--require spec_helper --bisect'
  end
end

namespace :rubocop do
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:lint) {}

  RuboCop::RakeTask.new(:fix) do |t|
    t.options = ['-a']
  end
end

desc 'Code coverage detail'
task :simplecov do
  Rake::Task['test'].execute
end

task default: ['rspec:test']

task rubocop: ['rubocop:lint']

task all: ['rubocop:lint', 'rspec:test', 'rspec:integration']

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  system('rm -rf docs')
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'docs'
  rdoc.title = "sovren-rest #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
