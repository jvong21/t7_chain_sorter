# Uses the "creek" ruby gem to parse an xlsx file
require_relative '../Move/t7_movelist'
require_relative '../Move/t7_move'
require 'creek'

class Creek_T7MoveList_Builder

    attr_reader :move_list 

    def initialize(file_name)
        @file_name = file_name 
        @creek_book = Creek::Book.new @file_name 
        @move_sheet = @creek_book.sheets[0]
        @move_list = T7_Movelist.new
        @running_command_list = Array.new 
    end 

    def create_and_get_move_list()
        if @move_list.empty?  
            @move_sheet.simple_rows.each do |row| 
                new_move = create_move_from_row(row)
                unless @running_command_list.include? new_move.command
                    @move_list << new_move 
                    @running_command_list << new_move.command 
                end 
            end 
        end
        @move_list.shift # remove first row because it is a header row
        @move_list
    end 

    private def create_move_from_row(row)
        # The columns per row are based on frame data from http://rbnorway.org/t7-frame-data/
        command = row["A"]
        hit_level = row["B"]
        start_up = row["D"]
        block_advantage = row["E"]
        hit_advantage = row["F"]
        counter_hit_advantage = row["G"]
        current_move = T7_Move.new(command, hit_level, start_up, block_advantage, hit_advantage, counter_hit_advantage)
        current_move
    end 

end 

#### Testing ####
# move_list_builder = Creek_T7MoveList_Builder.new('D:\JJ\Downloads\Alisa Frame Data T7FR.xlsx')
# move_list_builder.create_and_get_move_list # => returns move list 
# puts move_list_builder.move_list.count # => Returns 222 for alisa 
# move = move_list_builder.move_list[1] 
# All correct command information returns 
# puts "command: " + move.command 
# puts "hit level: " << move.hit_level 
# puts "startup: " << move.start_up
# puts "block_advantage: " << move.block_advantage
# puts "hit advantage: " << move.hit_advantage
# puts "counter hit advantage: " << move.counter_hit_advantage