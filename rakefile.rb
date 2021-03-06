# coding: utf-8
require 'rake/testtask'
require 'rdoc/task'
require "bundler/gem_tasks"

#Run the fOOrth unit test suite.
Rake::TestTask.new do |t|
  #List out all the test files.
  t.test_files = FileList['tests/**/*.rb']
  t.verbose = false
end

#Generate internal documentation with rdoc.
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"

  #List out all the files to be documented.
  rdoc.rdoc_files.include("lib/**/*.rb", "license.txt", "README.md")

  #Make all access levels visible.
  rdoc.options << '--visibility' << 'private'

  #Set a title.
  rdoc.options << '--title' << 'CompositeRng Docs'

end

desc "Run a scan for smelly code!"
task :reek do |t|
  `reek --no-color lib > reek.txt`
end

desc "Fire up an IRB session with composite_rng preloaded."
task :console do
  system "ruby irbt.rb local"
end

desc "What version of the composite_rng is this?"
task :vers do |t|
  puts
  puts "CompositeRng version = #{CompositeRng::VERSION}"
end
