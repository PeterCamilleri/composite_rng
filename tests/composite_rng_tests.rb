# coding: utf-8

require_relative '../lib/composite_rng'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

#Test the monkey patches applied to the Object class.
class CompositeRngTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

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
