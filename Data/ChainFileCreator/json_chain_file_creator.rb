require_relative '../move/sorting/chain_sorter'
require_relative '../move/t7_move'
require_relative '../move/t7_movelist'
require_relative '../builder/creek_t7movelist_builder'
require_relative '../move/tiered_move'
require 'oj'

class Json_Chain_File_Creator

    # Both of these parameters require full paths 
    def create_chain_file(source_xlsx, output_file) 
        move_list = create_move_list(source_xlsx)
        chain_list = create_chains(move_list)
        create_new_chain_file(chain_list, output_file)
    end

    private def create_move_list(source_xlsx)
        move_list_builder = Creek_T7MoveList_Builder.new(source_xlsx)
        move_list_builder.create_and_get_move_list 
    end

    private def create_chains(move_list)
        sorter = Chain_Sorter.new 
        sorter.create_and_get_move_chain_list(move_list)
    end 

    private def create_new_chain_file(chain_list, output_file)
        File::open(output_file, "w") do |file|
            whole_move_list = []
            build_move_text(chain_list, whole_move_list)
            file << (Oj::dump whole_move_list, :indent => 2)
        end 
    end 

    private def build_move_text(move_list, final_move_list) 
        move_list.each do |move_set|
            current_move_command = move_set[0].command.to_s unless move_set[0].nil? 
            current_tiered_move = Tiered_Move.new 
            current_tiered_move.command = current_move_command
            current_tiered_move.child_move = []
            current_tiered_move.full_move_details = move_set[0] 
            if(move_set[1].count > 0)
                build_move_text(move_set[1],current_tiered_move.child_move)
            end
            final_move_list << current_tiered_move
        end 
        return nil
    end 
end 





