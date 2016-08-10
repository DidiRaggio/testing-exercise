require_relative './lib/path_finder'

path_finder = PathFinder.new


#Determine how many patterns
number_of_patterns = gets.chomp.to_i

# Add patterns
number_of_patterns.times do 
  input = gets.chomp
  path_finder.add_pattern(input)
end

# Get number of paths to test
number_of_paths = gets.chomp.to_i

# Input patterns, also outputs expected output
number_of_paths.times do 
  input = gets.chomp
  path_finder.parse_path(input)
end