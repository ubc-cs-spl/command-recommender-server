class Recommendation
	attr_access :what, :kind, :description
	
	def initialize(what, kind, description)
		@what = what
		@kind = kind
		@description = description
	end
end
