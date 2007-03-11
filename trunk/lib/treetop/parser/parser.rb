module Treetop
  class Parser
    attr_reader :grammar, :node_cache
    
    def initialize(grammar)
      @grammar = grammar
    end

    def parse(input)
      @node_cache = NodeCache.new
      result = grammar.root.parse_at(input, 0, self)
      if result.success? and result.interval.end != input.size
        return ParseFailure.new(result.interval.end)
      else
        return result
      end
    end
  end
end