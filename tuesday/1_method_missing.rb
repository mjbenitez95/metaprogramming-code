class Lawyer
  def method_missing(method, *args)
    puts "You called: #{method}(#{args.join(', ')})"
    puts "(You also passed it a block)" if block_given?
  end
end

bob = Lawyer.new
bob.talk_simply('a', 'b') do 
  # a block
end

# real world usage example of Ghost Methods from the Hashie gem
module Hashie
  class Mash < Hashie::Hashie
    def method_missing(method_name, *args, &blk)
      return self.[](method_name, &blk) if key?(method_name)

      # checks for anything ended by zero or one of '?', '=', or '!'
      match = method_name.to_s.match(/(.*?)([?=!]?)$/) 

      case match[2]
      when "="
        self[match[1]] = args.first
        # ...
      else
        default(method_name, *args, &blk)
      end
    end
    
    # ...
  end
end

icecream = Hashie::Mash.new
icecream.flavor = "strawberry"
icecream.flavor

# If the name of a called method is the name of a key in the hash,
# then Hashie::Mash#method_missing calls the [] method to return
# the corresponding value. If the name ends with a "=", then 
# method_missing chops off the "=" at the end to get the attribute
# name and stores its value. If the name of the called method 
# doesn't match any of these cases, then method_missing just 
# returns a default value.
# ------------------------------------------

class Computer
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_sources
  end

  def mouse
    info = @data_source.get_mouse_info(@id)
    price = @data_source.get_mouse_price(@id)
    result = "Mouse: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def cpu
    info = @data_source.get_cpu_info(@id)
    price = @data_source.get_cpu_price(@id)
    result = "CPU: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end
  
  def keyboard
    info = @data_source.get_cpu_info(@id)
    price = @data_source.get_cpu_price(@id)
    result = "CPU: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  # ...
end

class Computer_With_Method_Missing
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_source
  end

  def method_missing(name)
    # handles base cases
    super if !@data_source.respond_to?("get_#{name}_info")

    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  # override respond_to_missing? to keep your class from 
  # lying about ghost methods when queried with respond_to?
  def respond_to_missing?(method, include_private = false)
    # the `or super` here is for methods that aren't ghosts
    @data_source.respond_to?("get_#{method}_info") || super
  end
end
