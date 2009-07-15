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
	# Example:
	#		include Treetop::Syntax
	# 	grammar :Simple do
	#			rule :foo do
	#				["foo", :bar]
	# 		end
	#
	#			rule :bar do
	#				"bar" / "baz"
	#			end
	# 	end
	#		parser = SimpleParser.new
	#
	#	Additional features like special operators (* + ?), bractets and
	# syntax node declarations will be implemented in the future.
	module Syntax
		class Grammar
			attr_reader :source
			def initialize
				@source = ""
			end

			def rule(name)
				@source += "rule #{name.to_s}\n"
				yield._to_tt.each_line do |line|
					@source << "  #{line}"
				end
				@source += "\nend\n"
			end
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
