#! /bin/ruby

# This file is to help generate large inputs

puts 'How many patterns?'
number_of_patterns = gets.chomp.to_i
puts 'How many paths?'
number_of_paths    = gets.chomp.to_i


string_options          = ['abc', 'def', 'ghi', 'jkl', 'mno', 'pqr']
pattern_string_options = string_options.push('*')
size_options    = [1, 2, 3, 4]

@file = File.open('test_input.txt', 'w+')

def write_to_file(value)
  @file.write("#{value}\n")
end

#tell us how many patterns
write_to_file(number_of_patterns)

#write patterns
number_of_patterns.times do 
  size = size_options.shuffle.sample
  pattern_string = ''
  size.times do 
    pattern_string += pattern_string_options.shuffle.sample + ','
  end
  # Output string without last comma
  write_to_file(pattern_string[0...-1])
end

#tell us how many paths
write_to_file(number_of_paths)

#Write paths
number_of_paths.times do 
  size = size_options.shuffle.sample

  #Random leading slash
  path_string = (rand > 0.7) ? '/' : ''
  size.times do 
    path_string += string_options.shuffle.sample + '/'
  end
  #randomly strip trailing slash
  if (rand > 0.5) 
    path_string = path_string[0...-1]
  end

  write_to_file(path_string)
end

@file.close
puts 'done'