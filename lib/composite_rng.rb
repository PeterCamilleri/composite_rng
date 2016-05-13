require_relative "composite_rng/version"

#A class of random number generators that work by nesting other PRNGs.
class CompositeRng

  #The limits on the churn limit.
  CHURNS = 2..256

  #The limits on the init.
  INITS = 0..256

  #The current upper limit on churn
  attr_reader :churn_limit

  #Create a composite PRNG
  #<br>Parameters
  #* parent - the starting PRNG
  #* child - the progeny PRNG
  #* churn_limit - the max amount of churning done.
  #* init = the number of initial churn steps.
  def initialize(parent, child, churn_limit=16, init=0)
    @parent, @child, @churn_limit = parent, child, churn_limit

    #Validate the churn_limit
    unless CHURNS === @churn_limit
      fail "Invalid churn limit #{@churn_limit}. Allowed values are #{CHURNS}"
    end

    #Validate the init
    unless INITS === init
      fail "Invalid init value #{init}. Allowed values are #{INITS}"
    end

    init.times { churn }
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
    (1 + @parent.rand(@churn_limit)).times {@child.rand(256)}
    @child
  end

end
