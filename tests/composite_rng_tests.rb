# coding: utf-8

require_relative '../lib/composite_rng'
gem              'minitest'
require          'minitest/autorun'

#Test the monkey patches applied to the Object class.
class CompositeRngTester < Minitest::Test

  def test_that_it_checks_parms
    assert_raises { CompositeRng.new(Random.new, Random.new,  -1, 0) }
    assert_raises { CompositeRng.new(Random.new, Random.new, 300, 0) }

    assert_raises { CompositeRng.new(Random.new, Random.new, 2,  -1) }
    assert_raises { CompositeRng.new(Random.new, Random.new, 2, 300) }
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
