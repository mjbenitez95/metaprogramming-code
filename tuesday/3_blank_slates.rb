# frozen_string_literal: true

class ComputerWithMethodMissingBuggy
  # though this class implementation looks good,
  # it fails to handle cases where the method we're trying
  # to handle is a preexisting method (such as `display`)

  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name)
    super unless @data_source.respond_to?("get_#{name}_info")

    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100

    result
  end

  def respond_to_missing?(method, include_private = false)
    @data_source.respond_to?("get_#{method}_info") || super
  end
end

class BlankSlateComputer < BasicObject
  # inheriting from BasicObject (as opposed to Object, which
  # is what classes inherently subclass) will allow our class
  # to have a bare minimum of instance methods, providing a
  # good starting point (or blank slate) for our implementation.

  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name)
    super unless @data_source.respond_to?("get_#{name}_info")

    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100

    result
  end
end
