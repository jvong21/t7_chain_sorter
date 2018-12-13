require_relative 'move'
require_relative 't7_move'

class MoveList < Array 

    @@move_type = Move

    def push(move)
        check_move_type(move)
        super(move)
    end 

    def unshift(move)
        check_move_type(move)
        super(move) 
    end 

    def insert(position, move) 
        check_move_type(move)
        super(move) 
    end 

    private def check_move_type(move)
        raise ArgumentError, "The provided move is not of type #{@@move_type}" unless move.is_a? @@move_type 
    end 

end 

#### Testing ####
# generic_move_list = MoveList.new 
# generic_move = Move.new("Test Commando")
# new_move = T7_Move.new(1, 2, 3, 4, 5)
# generic_move_list.push(1) # => Throws error 
# generic_move_list.push(generic_move) # => ok
# generic_move_list.push(new_move) # => ok
# puts generic_move_list.length # => 2 