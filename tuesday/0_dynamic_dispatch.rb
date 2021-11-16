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

class Computer_Dynamic_Dispatch
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_sources
  end

  def component(name)
    info = @data_source.send("get_#{name}_info", @id)
    price = @data_source.send("get_#{name}_price", @id)
    result = "#{name.capitalize}: #{info} ($#{price})"
    return "* #{result}" if price >= 100
    result
  end

  def mouse
    component :mouse
  end

  def cpu
    component :cpu
  end
  
  def keyboard
    component :keyboard
  end

  # ...
end

class Computer_Dynamic_Methods
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_sources
  end

  def self.define_component(name)
    define_method(name) do
      info = @data_source.send("get_#{name}_info", @id)
      price = @data_source.send("get_#{name}_price", @id)
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

  define_component :mouse
  define_component :cpu
  define_component :keyboard

  # ...
end

class Computer_Dynamic_Methods_By_Introspection
  def initialize(computer_id, data_source)
    @id = computer_id
    @data_source = data_sources

    # this line uses introspection into the data_source to define methods for all components
    # a bonus benefit to this is that if data_source adds another component, this class
    # will automatically support it.
    data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end

  def self.define_component(name)
    define_method(name) do
      info = @data_source.send("get_#{name}_info", @id)
      price = @data_source.send("get_#{name}_price", @id)
      result = "#{name.capitalize}: #{info} ($#{price})"
      return "* #{result}" if price >= 100
      result
    end
  end

end
