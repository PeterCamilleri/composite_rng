require "composite_rng/version"

#A class of random number generators that work by nesting other PRNGs.
class CompositeRng

  #Create a composite PRNG
  #<br>Parameters
  #* parent - the starting PRNG
  #* child - the progeny PRNG
  #* churn - the amount of churning done.
  def initialize(parent, child, churn=16)
    @parent, @child, @churn = parent, child, churn
  end

  #An access point for random numbers.
  #<br>Parameters
  #* max - the range of the numbers to be created.
  def rand(max=0)
    churn(max).rand(max)
  end

  #Stir the soup!
  #<br>Parameters
  #* max - the range of the numbers to be discarded.
  def churn(max=256)
    (1 + @parent.rand(@churn)).times {@child.rand(max)}
    @child
  end

end
