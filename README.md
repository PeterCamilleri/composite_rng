# CompositeRng

The composite (psuedo) random number generator is a container for two other
(psuedo) random number generators. By working together, these create higher
quality random number streams than either could by itself.

The two generators do NOT need to be the same type. While not a good idea,
they may even be the same instance, or the same type with the same seed, but
this negates the advantage of compositing them.

The generators used must comply to the following duck characteristics:

    rand(max) - This method must compute a random integer from 0...max

That's all! The following shows how this could work:
```ruby
parent = Random.new #Get the built in Mersenne Twister MT19937 PRNG
child  = Random.new
composite = CompositeRng.new(parent, child, 42)
# ...
dice_roll = 1 + composite.rand(6)
# ...
```
The constructor takes three arguements:
* The parent PRNG that is used to "educate" the child.
* The child PRNG that is the actual generator of data.
* The churn factor that controls how much tutoring the child is to receive.
This optional parameter defaults to 16.

It is also possible to use the default PRNG as follows:
```ruby
parent = Object.new
child  = Random.new
composite = CompositeRng.new(parent, child)
# ...
dice_roll = 1 + composite.rand(6)
# ...
```
This is because the default PRNG exists as methods of Object. Note that (as
far as I can tell) only one instance of that PRNG exists, so it should only
be used as parent or child but never both!.

The composite generator also works with custom generator, that support rand(n)
like my own Fibonacci generator:

```ruby
parent = Random.new
child  = FibonacciRng.new(depth: 12)
composite = CompositeRng.new(parent, child)
# ...
dice_roll = 1 + composite.rand(6)
# ...
```

#### Accessing advanced methods with churn

Most PRNGs provide more resources beyond the basic "rand" method. Access to
these other methods is provided by using the churn method. The churn method
returns the child PRNG after it has received a suitable period of instruction
from the parent PRNG. An example, accessing the bytes method of the Random
class follows:
```ruby
# Get a string of 22 random chars.
crazy_string = composite.churn.bytes(22)
```
While this code seems to work, it really is weak tea. The issue is that the
education process is only carried out once. The following code does a much
more thorough job:
```ruby
# Get a string of 22 random chars.
crazy_string = 22.times.inject("") { |s| s << composite.churn.bytes(1) }
```

## Installation

Add this line to your application's Gemfile:

    gem 'composite_rng'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install composite_rng

The composite_rng gem itself is found at: ( https://rubygems.org/gems/composite_rng )

The fibonacci_rng code lives at: ( https://github.com/PeterCamilleri/fibonacci_rng )

## Contributing

#### Plan A

1. Fork it ( https://github.com/PeterCamilleri/composite_rng/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### Plan B

Go to the GitHub repository and raise an issue calling attention to some
aspect that could use some TLC or a suggestion or an idea.
