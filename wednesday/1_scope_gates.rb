#                                # SCOPE GATE: entering top-level scope at start of execution
v1 = 1                           

class MyClass                    # SCOPE GATE: entering class
  v2 = 2
  local_variables # => ["v2"]

  def my_method                  # SCOPE GATE: entering method definition
    v3 = 3
    local_variables
  end                            # SCOPE GATE: exiting method definition
  
  local_variables # => ["v2"]
end                              # SCOPE GATE: exiting class

obj = MyClass.new
puts obj.my_method
puts local_variables
#                                # SCOPE GATE: exiting top-level scope at end of execution
