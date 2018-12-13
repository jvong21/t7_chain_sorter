require_relative '../movelist'

class Chain_Sorter 

    attr_reader :chainable_move_list

    def create_and_get_move_chain_list ( move_list ) 
        move_list_copy = move_list.dup 
        chainable_move_list = Array.new
        
        current_move = move_list_copy.shift  

        while current_move != nil and current_move.command != nil do
            current_chainable_move = create_chainable_move(current_move, move_list_copy)
            chainable_move_list.push(current_chainable_move)
            current_move = move_list_copy.shift  
        end 
        @chainable_move_list = chainable_move_list.compact
        @chainable_move_list
    end 

    private def create_chainable_move ( move, move_list )
        current_chainable_move = [ move, Array.new ]
        processed_child_moves = Array.new 
        start_of_move = move.command.dup << ',' # Ensures that this move actually starts a chain for a child move 
        move_size = move.command.dup.split(',').length 
        move_list.each do | child_move | 
            unless child_move.command.nil? 
                child_move_size = child_move.command.dup.split(',').length
                move_size_difference = (child_move_size - move_size ) 
                if child_move.command.start_with?(start_of_move) && (move_size_difference == 1) # Only operate on child moves that start with the move, and is only one command length longer 
                    new_chainable_move = create_chainable_move(child_move, move_list)
                    current_chainable_move[1] << new_chainable_move
                    processed_child_moves.push(child_move) 
                end
            end
        end
        delete_processed_child_moves(processed_child_moves, move_list) # Ensures that none of the child moves are considered as chain starters
        current_chainable_move 
    end 

    private def delete_processed_child_moves(moves_to_delete, move_list)
        moves_to_delete.each do |move_to_delete|
            move_list.delete(move_to_delete)
        end
    end

end 

#### Testing ####
# sorter = Chain_Sorter.new 
# movelist = MoveList.new 
# movelist.push(Move.new("command1"))
# movelist.push(Move.new("command1, command2"))
# movelist.push(Move.new("butt2"))
# movelist.push(Move.new("command1, command2, command3"))

# sorter.create_and_get_move_chain_list(movelist)

# puts sorter.chainable_move_list => Returns all of the moves in the correct order above
