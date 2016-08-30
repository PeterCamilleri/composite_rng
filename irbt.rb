# coding: utf-8
# An IRB + composite_rng Test bed

require 'irb'

puts "Starting an IRB console with composite_rng loaded."

if ARGV[0] == 'local'
  require_relative 'lib/composite_rng'
  puts "composite_rng loaded locally: #{CompositeRng::VERSION}"

  ARGV.shift
else
  require 'composite_rng'
  puts "composite_rng loaded from gem: #{CompositeRng::VERSION}"
end

begin
  require 'fibonacci_rng'
  puts "fibonacci_rng loaded from gem: #{FibonacciRng::VERSION}"
rescue
  puts "fibonacci_rng not loaded."
end

IRB.start
