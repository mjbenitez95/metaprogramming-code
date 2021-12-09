module Kernel
  def using(resource)
    begin
      yield if block_given?
    ensure
      resource.dispose
    end
  end
end

# ---
def binding_example
  x = "Goodbye"
  yield("cruel")
end

x = "Hello"
# the block defined below picks up the x binding above
puts binding_example {|y| "#{x}, #{y} world!" } # => "Hello, cruel world!"
puts "--"

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
puts "--"

# ---
# scope_change_example
# ---
v1 = 1
class MyClass
  v2 = 2
  puts local_variables # => v2
  
  def my_method
    v3 = 3
    puts local_variables # => v3
  end

  puts local_variables # => v2
end
obj = MyClass.new # => v2, v2 (v1 will not show up in the inner scope)
obj.my_method # => v3
obj.my_method # => v3
puts local_variables # => v1, obj
puts "--"

# ---
# global_variable_example
# ---
def a_scope
  $var = "some value"
end

def another_scope
  $var
end

a_scope
puts another_scope # => "some value"
puts "--"

# ---
# we can use a top level variable instead of global
# ---
@var = "The top level variable!"

def my_method
  @var
end

class SomeClass
  def my_method
    @var = "Not the top level variable!"
  end
end

some_class = SomeClass.new
puts my_method, some_class.my_method
puts "--"
