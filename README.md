# CompositeRng

The composite (psuedo) random number generator is a container for two other
(psuedo) random number generators. By working together, these create higher
quality random number streams than either could by itself.

The two generators do NOT need to be the same type. While not a good idea,
they may even be the same instance, or the same type with the same seed, but
this negates the advantage of compositing them.

The generators used most comply to the following duck characteristics:

    rand(max) - This method must compute a random integer from 0...max

That's all! The following shows how this could work:

    parent = Random.new #Get the built in Mersenne Twister MT19937 PRNG
    child  = Random.new
    composite = CompositeRng.new(parent, child)
    # ...
    dice_roll = composite(6)
    # ...

It is also possible to use the default PRNG as follows:

    parent = Object.new
    child  = Random.new
    composite = CompositeRng.new(parent, child)
    # ...
    dice_roll = composite(6)
    # ...

This is because the default PRNG exists as methods of Object. Note that (as
far as I can tell) only one instance of that PRNG exists, so it should only
be used as parent or child but never both!.

Most PRNGs provide more resources beyond the basic "rand" method. Access to
these other methods is provided by using the churn method. An example,
accessing the bytes method of the Random class follows:

    crazy_string = composite.churn.bytes(22) # Get a string of 22 random chars.

## Installation

Add this line to your application's Gemfile:

    gem 'composite_rng'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install composite_rng

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
