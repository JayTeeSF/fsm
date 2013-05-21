class Fsm
  class Graph
    # like a single hash entry w/
    # key:   2-dim array of arrays
    # value: array
    class NodeInputEdgeMap
      attr_reader :nodes, :inputs, :edges
      def initialize( nodes, inputs, edges )
        @nodes = nodes
        @inputs = inputs
        @edges = edges
      end
      def edges_for( node, input )
        if nodes.include?( node ) && inputs.include?( input )
          edges
        else
          []
        end
      end
    end
  end
end
