class PathFinder
  attr_accessor :pattern_tree

  def initialize
    @pattern_tree = PathFinder::Node.new('')
  end

  # Parses the input into a regex and stores it
  def add_pattern(input)
    last_node = @pattern_tree
    input.split(',').each do |new_node_value|
      existing_node = last_node.children[new_node_value]
      if existing_node
        last_node = existing_node
      else
        new_node = PathFinder::Node.new(new_node_value)
        # If newNodeValue = '*' then we put it last on the tree
        #so it is searched last
        last_node.children[new_node_value] = new_node

        # Next part should be a child of this
        last_node = new_node
      end
    end
  end#end PathFinder#add_pattern

  #Parses a path and checks it against the patterns
  def parse_path(input)
    output                  = nil
    matching_pattern_parts  = nil
    last_node               = @pattern_tree
    
    input.split('/').each do |path_part|
      # Skip leading /
      next if path_part == ''

      # Look for matching children
      existing_child          = last_node.children[path_part]
      existing_wildcard_child = last_node.children['*']
      matched_child = nil

      # Check for exact matching child then check for wildcard
      if existing_child
        matched_child = existing_child
      elsif existing_wildcard_child
        matched_child = existing_wildcard_child
      end

      # If we haven't matched anything even 
      # and there are more children 
      # we have matched nothing
      if matched_child.nil?
        output = nil
        break
      end

      # build output
      if matching_pattern_parts.nil?
        matching_pattern_parts = matched_child.value
      else
        matching_pattern_parts += ',' + matched_child.value
      end

      # No more children we've reached the end of a path
      if matched_child.children.empty?
        output = matching_pattern_parts
        break
      end

      # Move down a level
      last_node = matched_child
    end

    # If it matched no patterns then output 'NO MATCH'
    puts output.nil? ? 'NO MATCH' : output
  end #end PathFinder#parse_path

  class Node
    attr_accessor :children, :value

    def initialize(v)
      @value = v
      @children = {}
    end

    def exist?
      true
    end
  end #end PathFinder::Node

end #end PathFinder