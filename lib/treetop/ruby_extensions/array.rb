class Array
	def join_with(method, pattern = "")
		return join(pattern) unless method
		return "" if self.length == 0
		output = self[0].send(method)
		for i in (1...self.length)
			output += pattern + self[i].send(method)
		end
		output
	end

	def to_tt
		self.join_with(:to_tt, " ")
	end
end
