
class Element 

	def initialize(title)
		@title = title
		@keys = Hash.new
		@tags = Array.new
		@childs = Array.new
	end
	attr_accessor :title
	attr_accessor :keys
	attr_accessor :tags
	attr_accessor :childs
	
end

class Document < Element

	def initialize(title)
		super(title)
	end
end

class Page < Element

	def initialize(title)
		super(title)
	end
end