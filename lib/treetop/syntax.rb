=begin rdoc
	Definition of TreeTop syntax in pure Ruby.
=end

module Treetop
	# Provides the possibility to write Treetop syntax as a Ruby code.
	# Symbols act as nonterminals, strings as terminals, arrays as
	# sequences. Ordered choices are defined similar to original Treetop
	# syntax.
	#
	# (Note: it is better not to use numbers; use Strings instead)
	#
	module Syntax
		class Grammar
			attr_reader :source
			def initialize
				@source = ""
			end

			def rule(name)
				@source += "rule #{name.to_s}\n"
				yield.seq_to_tt.each_line do |line|
					@source << "  #{line}"
				end
				@source += "\nend\n"
			end
		end

		def grammar(name, &block)
			Syntax.grammar(name, &block)
		end

		def self.grammar(name, &block)
			source = "grammar #{name.to_s}\n"
			(g = Grammar.new).instance_eval(&block)
			g.source.each_line do |line|
				source << "  #{line}"
			end
			Treetop.load_from_string(source + "end\n")
		end
	end
end
