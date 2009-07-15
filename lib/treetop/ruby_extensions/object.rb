class Object
	def sequence
		@sequence ||= []
	end

	def /(other)
		sequence.push(other)
		self
	end

	def seq_to_tt(inline = false)
		separator = inline ? " / " : "\n/\n"
		tt = if sequence.length == 0
			self.to_tt
		else
			output = self.to_tt + separator + sequence.join_with({:name => :seq_to_tt, :args => [true]}, separator)
			output = "( #{output} )" if inline
			output
		end
		tt += "*" if @kleene
		tt += "+" if @one
		tt += "?" if @optional
		tt += " <#{@node.to_s}>" if @node
		tt += " {\n#{@block.gsub("\t", "  ").justify.indent_paragraph(2)}\n}" if @block
		tt
	end

	def node(name)
		@node = name
		self
	end

	def block(content)
		@block = content
		self
	end

	def _?
		@optional = true
		self
	end

	def kleene
		@kleene = true
		self
	end

	def plus
		@one = true
		self
	end
end
