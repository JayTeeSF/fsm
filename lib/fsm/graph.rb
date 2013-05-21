glob_string = File.dirname(__FILE__) + '/graph/*.rb'
glob_files = Dir[ glob_string ]
glob_files.each do |file|
  file_base = File.basename(file, File.extname(file))
  file_dirname = File.dirname(file)
  require_path = "#{file_dirname}/#{file_base}"
  require require_path
end

class Fsm
  class Graph
      attr_reader :nie_maps
    # FIXME: nomenclature -
    # node and edge criteria
    # state and transition criteria
    def initialize( node_input_edge_maps )
      @nie_maps = node_input_edge_maps
    end

    # need a version that accepts a block
    # ...for yielding each (uniq) result
    def states_for( state, input_char )
      (nie_maps.reduce([]){|results,nie_map|
        results += nie_map.edges_for( state, input_char )
      }).uniq
    end
  end
end
