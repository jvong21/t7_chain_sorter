# Sample usage of the chain file creator
require_relative 'ChainFileCreator/chain_file_creator'

chain_file_creator = Chain_File_Creator.new

chain_file_creator.create_chain_file("../FrameData/Alisa Frame Data T7FR.xlsx", "../FrameData/Alisa.txt")