class Object
	def sequence
		@sequence ||= [self]
	end

	def /(other)
		sequence.push(other)
		self
	end

	def _to_tt
		sequence.join_with(:to_tt, "\n/\n")
	end
end
