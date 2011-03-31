require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'rake/testtask'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "gogoodreads"
  gem.homepage = "http://github.com/iamteem/gogoodreads"
  gem.license = "MIT"
  gem.summary = %Q{Goodreads API Ruby Interface}
  gem.description = %Q{Allows you to progammatically pull book reviews from Goodreads using its API.}
  gem.email = "iamteem@gmail.com"
  gem.authors = ["Tim Medina"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
   gem.add_runtime_dependency 'nokogiri'
end
Jeweler::RubygemsDotOrgTasks.new

require 'yard'
YARD::Rake::YardocTask.new

desc "Run test suite."
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
