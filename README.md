# CompositeRng

The composite (psuedo) random number generator is a container for two other
(psuedo) random number generators. By working together, these generators
create higher quality pseudo-random number streams than either could create
by itself.

## Installation

Add this line to your application's Gemfile:

    gem 'composite_rng'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install composite_rng

The composite_rng gem itself is found at: ( https://rubygems.org/gems/composite_rng )

##Usage

```ruby
require 'composite_rng'
```

Then in an appropriate place in the code:

```ruby
@my_rng = CompositeRng.new(parent, child, churn, init)
```
Where:
* parent is a random number generator used to educate the child.
* child is the random number generator used to generate the output.
* churn is the limit on the education process. Default 16, Range 2..256
* init is the number of initial churns done during initialization. Default 0, Range 0..256

The parent and child generators do not need to be the same type. In fact it
helps to reduce any possible correlation between the parent and the child
if they are completely different sorts of generators. It is a really bad
idea for them to be either the same instance, or the same type with the same
seed, because this negates the advantage of compositing generators.

To be used in a composite generator, both generators used must implement the
following method:

    rand(max)

which method must return a pseudo-random integer in 0...max.

The following are examples of this class in action.
```ruby
parent = Random.new #Get the built in Mersenne Twister MT19937 PRNG
child  = Random.new
composite = CompositeRng.new(parent, child, 42, 11)
# ...
dice_roll = 1 + composite.rand(6)
# ...
```

The composite generator also works with custom generators that support rand(n).
For example my own Fibonacci generator:

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

## License

The gem is available as open source under the terms of the
[MIT License](./LICENSE.txt).

## Code of Conduct

Everyone interacting in the fully_freeze project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](./CODE_OF_CONDUCT.md).
