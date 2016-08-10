# spec/path_finder_spec.rb
require 'path_finder'

describe PathFinder do
  before :each do
    @path_finder = PathFinder.new
  end
  
  describe '.new' do
    it 'should have an empty tree' do
      expect(@path_finder.pattern_tree.value).to eql('')
      expect(@path_finder.pattern_tree.children).to eql({})
    end
  end

  describe '#add_pattern' do
    it 'should extend the pattern tree, by splitting input by ,' do
      @path_finder.add_pattern('abc,bcd')  
      expect(@path_finder.pattern_tree.children).to_not eql({})
      expect(@path_finder.pattern_tree.children['abc']).to exist
      expect(@path_finder.pattern_tree.children['abc'].children['bcd']).to exist

      #extend existing node with another child
      expect {@path_finder.add_pattern('abc,ddd')}.to change{@path_finder.pattern_tree.children['abc'].children.keys.count}.by(1)
    end
  end


  describe '#parse_path' do
    before :each do 
      @path_finder = PathFinder.new
      @path_finder.add_pattern('abc,bcd,efg')
      @path_finder.add_pattern('abc,bcd,*')
      @path_finder.add_pattern('*,abc,bcd')
      @path_finder.add_pattern('abc,*,ggg')
    end

    it 'should output pattern with least wildcards' do
      expect{@path_finder.parse_path('abc/bcd/efg')}.to output("abc,bcd,efg\n").to_stdout
    end

    it 'should output pattern with rightmost first wildcard' do 
      expect{@path_finder.parse_path('abc/bcd/ggg')}.to output("abc,bcd,*\n").to_stdout
    end

    it 'should output "NO MATCH \n" if there is no match' do 
      expect{@path_finder.parse_path('ggg/ggg/ggg')}.to output("NO MATCH\n").to_stdout
    end

    it 'should not output partial matches' do 
      expect{@path_finder.parse_path('abc/bcd')}.to output("NO MATCH\n").to_stdout
    end

    it 'should not care about leading nor trailing slashes' do
      expected_output = "abc,bcd,*\n"
      expect{@path_finder.parse_path('abc/bcd/ggg')}.to output(expected_output).to_stdout
      expect{@path_finder.parse_path('/abc/bcd/ggg')}.to output(expected_output).to_stdout
      expect{@path_finder.parse_path('abc/bcd/ggg/')}.to output(expected_output).to_stdout
      expect{@path_finder.parse_path('/abc/bcd/ggg/')}.to output(expected_output).to_stdout
    end

    it 'outputs with a unix newline for each output' do
      expect{@path_finder.parse_path('abc/bcd')}.to output("NO MATCH\n").to_stdout
      expect{@path_finder.parse_path('abc/bcd/ggg')}.to output("abc,bcd,*\n").to_stdout
    end
  end
end

describe PathFinder::Node do
  before :each do
    @node = PathFinder::Node.new('value')
  end

  describe '.new' do
    it 'should have assign value and have blank children hash' do 
      expect(@node.value).to eq('value')
      expect(@node.children).to eq({})
    end
  end

  describe '#exist?' do
    it 'should return true' do 
      expect(@node.exist?).to eq(true)
    end
  end
end