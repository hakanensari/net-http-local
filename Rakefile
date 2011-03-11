require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc "Run the test suite"
task :test do
  Dir['test/**/*_test.rb'].each do |f|
    ruby(f)
  end
end
