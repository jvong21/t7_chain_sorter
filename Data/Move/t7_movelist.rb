require_relative 'movelist'
require_relative 't7_move'

class T7_Movelist < MoveList 

    @@move_type = T7_Move

end 

#### Testing ####
# generic_move_list = T7_Movelist.new 
# generic_move = Move.new("Test Commando") 
# new_move = T7_Move.new(1, 2, 3, 4, 5)
# generic_move_list.push(1) # => Throws error 
# generic_move_list.push(generic_move) # => Throws error
# generic_move_list.push(new_move) # => ok
# puts generic_move_list.length # => 2 