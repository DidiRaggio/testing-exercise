HOW TO RUN SCRIPT
-----------------
cat input_file | ruby path_matcher.rb > output_file



NOTES ON COMPLEXITY
-------------------
The complexity of this solution should be o(log N) where N is the number of parts of patterns + the number of parts of paths.  This is because the tree for pattern matching checks against a hash for children meaning you can avoid iterating over arrays over and over again.


UNIT TESTS
----------
Unit tests were implemented with rspec.  It is easiest to install bundler and have that install the gems then you just need to run `rspec`


TESTING_HELP
------------
To create a sample input file of any size you can use 
`ruby testing_help/random_input_generator.rb `

then just run
`cat testing_help/test_input.txt | ruby path_matcher.rb`