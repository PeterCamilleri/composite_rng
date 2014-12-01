# coding: utf-8

require_relative '../lib/composite_rng'
require          'minitest/autorun'

#Test the monkey patches applied to the Object class.
class CompositeRngTester < MiniTest::Unit::TestCase

  #Special initialize to track rake progress.
  def initialize(*all)
    $do_this_only_one_time = "" unless defined? $do_this_only_one_time

    if $do_this_only_one_time != __FILE__
      puts
      puts "Running test file: #{File.split(__FILE__)[1]}"
      $do_this_only_one_time = __FILE__
    end

    super(*all)
  end

  def test_that_it_creates_dice_rolls
    prng = CompositeRng.new(Random.new, Random.new)

    100.times do
      assert((0...6) === prng.rand(6))
    end
  end

  def test_random_string
    prng = CompositeRng.new(Random.new, Random.new)

    rs = prng.churn.bytes(10)

    assert(rs.is_a?(String))
    assert_equal(10, rs.length)
  end

end
