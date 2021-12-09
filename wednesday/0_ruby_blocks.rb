module Kernel
  def using(resource)
    begin
      yield if block_given?
    ensure
      resource.dispose
    end
  end
end

def binding_example
  x = "Goodbye"
  yield("cruel")
end

x = "Hello"
# the block defined below picks up the x binding above
puts binding_example {|y| "#{x}, #{y} world!" } # => "Hello, cruel world!"

def just_yield
  yield
end

def inside_block_binding
  top_level_variable = 1

  just_yield do
    top_level_variable += 1
    local_to_block = 1
  end

  puts top_level_variable # => 2
  # puts local_to_block # => error!
end

inside_block_binding
