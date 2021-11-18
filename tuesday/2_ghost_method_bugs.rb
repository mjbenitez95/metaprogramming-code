# frozen_string_literal: true

class BuggyRoulette
  def method_missing(name, *_args)
    person = name.to_s.capitalize
    3.times do
      number = rand(1..10)
      puts "#{number}..."
    end

    "#{person} got a #{number}!"

    # number is no longer in scope, so Ruby thinks it's
    # a method call as opposed to a variable

    # this is clearly a problem since number isn't
    # defined, so method_missing will call itself
  end
end

class BetterRoulette
  def team_members
    %w[
      Matthew Kim Dorie DDM
      Donovan Graham Matt Joshua
      Jacob Ivailo Evan
    ]
  end

  def method_missing(name, *args)
    person = name.to_s.capitalize

    # this clause will make the previous bug noisy
    super unless team_members.include?(person)

    # and this definition will remove the bug
    number = 0

    3.times do
      number = rand(1..10)
      puts "#{number}..."
    end

    number = rand(1..10)
    "#{person} got a #{number}!"
  end
end

roulette = BetterRoulette.new
puts roulette.Matthew
