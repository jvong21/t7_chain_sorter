require_relative '../move/sorting/chain_sorter'
require_relative '../move/t7_move'
require_relative '../move/t7_movelist'
require_relative '../builder/creek_t7movelist_builder'

class Chain_File_Creator

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
            build_move_text(chain_list, "", file)
        end 
    end 

    private def build_move_text(move_list, padding, file) 
        move_list.each do |move_set|
            current_move_command = move_set[0].command.to_s unless move_set[0].nil? 
            file << padding << current_move_command << "\n"
            if(move_set[1].count > 0)
                new_padding = padding.dup << "    " # Originally opted to use string interpolation with padding, but produced inconsistent results
                build_move_text(move_set[1], new_padding, file)
            end 
        end 
    end 

end 





