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
		tt += " <#{@node.to_s}>" if @node
		tt
	end

	def node(name)
		@node = name
		self
	end
end
