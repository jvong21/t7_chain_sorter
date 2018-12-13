require_relative 'move'

class T7_Move < Move 
    move_properties :command, :hit_level, :start_up, :block_advantage, :hit_advantage, :counter_hit_advantage

end 

#### Testing ####
# new_move = T7_Move.new(1, 2, 3, 4, 5)
# puts new_move.hit_level