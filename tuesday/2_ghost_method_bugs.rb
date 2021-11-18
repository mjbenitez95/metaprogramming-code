class BuggyRoulette
  def method_missing(name, *args)
    person = name.to_s.capitalize
    3.times do
      number = rand(10) + 1
      puts "#{number}..."
    end

    "#{person} got a #{number}!"

    # number is no longer in scope, so Ruby thinks it's
    # a method call as opposed to a variable

    # this is clearly a problem since number isn't 
    # defined, so method_missing will call itself
  end
end

roulette = BuggyRoulette.new
puts roulette.Matthew
