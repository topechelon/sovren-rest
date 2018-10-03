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
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = 'sovren-rest'
  gem.homepage = 'http://github.com/SynergyDataSystems/sovren-rest'
  gem.license = 'MIT'
  gem.summary = %(Sovren 9.0 Rest)
  gem.description = %(Interfaces with the Sovren 9.0 REST API)
  gem.email = 'tendevsv3@patriotsoftware.com'
  gem.authors = ['TEN Devs V3']

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |test|
  test.pattern = 'spec/**/*_spec.rb'
  test.rspec_opts = '--color --require spec_helper --format documentation'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['-a']
end

desc 'Code coverage detail'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end

task default: :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sovren-rest #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
