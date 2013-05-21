# nie1 = Fsm::Graph::NodeInputEdgeMap.new([1,2], ['a'], [2])
# nie2 = Fsm::Graph::NodeInputEdgeMap.new([2,3], ['1'], [3])
# graph = Fsm::Graph.new([nie1, nie2])
##
#> graph.states_for( 2, '1' )
# => [3]
#> graph.states_for( 3, '1' )
# => [3]
#> graph.states_for( 3, 'a' )
# => []
#> graph.states_for( 2, 'a' )
# => [2]
#> graph.states_for( 1, 'a' )
# => [2]
##
# acceptance_states = [3]
# fsm = Fsm.new( graph, acceptance_states )
##
#> fsm.valid?("aaa111", 1)
# => true
#> fsm.valid?("abaa111", 1)
# => false
##
glob_string = File.dirname(__FILE__) + '/fsm/*.rb'
# puts "glob_string: #{glob_string.inspect}"
glob_files = Dir[ glob_string ]
# puts "glob_files: #{glob_files.inspect}"
glob_files.each do |file|
  file_base = File.basename(file, File.extname(file))
  file_dirname = File.dirname(file)
  require_path = "#{file_dirname}/#{file_base}"
  # puts "requiring: #{require_path} (from: #{file})"
  require require_path
end
class Fsm
  attr_reader :graph, :acceptance_states
  def initialize( graph, acceptance_states )
    @graph = graph
    @acceptance_states = acceptance_states
  end

  def valid?( input_string, current_state )
    if input_string.empty? && acceptance_states.include?( current_state )
      return true
    end
    current_char = input_string[0]
    remaining_string = input_string[1..-1]
    # need a loop:
    possible_states = graph.states_for( current_state, current_char )
    return false if possible_states.empty?

    possible_states.each do |possible_state|
      if result = valid?( remaining_string, possible_state )
        return result
      end
    end
    return false
  end
end
