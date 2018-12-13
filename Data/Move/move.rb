# Metaclass for a move, which adds attribute readers for each property, and creates an initialization method to accommodate N properties
# This defines a move with a command only. Children of this class can implement more properties. 
class Move

    def self.metaclass; class << self; self; end; end

    def self.move_properties ( *properties )

        attr_reader( *properties )

        class_eval do 
            define_method( :initialize ) do | *initialize_properties |
                properties.each_with_index do | property_name, index |
                    instance_variable_set("@#{property_name}", initialize_properties[index])
              end
            end
        end 
    end

    move_properties :command 
end 