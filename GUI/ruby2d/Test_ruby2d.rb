# Can only run from mingw64 due to installation of simple2d
# C:/Users/JJ/Desktop/Ruby_Movelist/GUI/ruby2d
require 'ruby2d'
require_relative '../../data/move/sorting/chain_sorter'
require_relative '../../data/move/t7_move'
require_relative '../../data/move/t7_movelist'
require_relative '../../data/builder/creek_t7movelist_builder'


class T7_Chain_Helper 

    attr_reader :chain_move_list

    def create_move_list 
        move_list_builder = Creek_T7MoveList_Builder.new('D:\JJ\Downloads\Alisa Frame Data T7FR.xlsx')
        move_list = move_list_builder.create_and_get_move_list 
        sorter = Chain_Sorter.new 
        sorter.create_move_chain_list(move_list)
        @chain_move_list = sorter.chainable_move_list
    end 
end 

set title: "Tekken 7 Chain Helper"
set resizable: true 

$current_y_iteration = 1

def build_move_text(move_list, current_x_position) 
    move_list.each do |move_set|
        $current_y_iteration = $current_y_iteration + 1
        current_move_command = move_set[0].command.to_s unless move_set[0].nil? # Not sure why nil ia being found, even though they should not be part of the array 
        Text.new(current_move_command, x: current_x_position, y: $current_y_iteration * 20)
        if(move_set[1].count > 0)
            build_move_text(move_set[1], current_x_position + 20)
        end 
    end 
end 

chain_helper = T7_Chain_Helper.new 

chain_helper.create_move_list 
move_list = chain_helper.chain_move_list 
build_move_text(move_list, 1)

show

