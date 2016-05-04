require_relative "composite_rng/version"

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
  #<br>Returns
  #* a random value generated according to the max parameter.
  def rand(max=0)
    churn.rand(max)
  end

  #Stir the soup!
  #<br>Returns
  #* a churned random number generator.
  def churn
    (1 + @parent.rand(@churn)).times {@child.rand(256)}
    @child
  end

end
