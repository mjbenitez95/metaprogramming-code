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

