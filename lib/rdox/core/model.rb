
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
	
	def pack()
		childs.each do |child|
			tags.each do |tag|
				if !child.tags.include?(tag) then
					child.tags << tag
				end
			end
			child.tags.sort_by { |tag| tag.to_s }
			keys.keys.each do |key|
				if keys[key] != nil && child.keys[key] == nil then
			 		child.keys[key] = keys[key]
				end
			end
			child.pack()
		end
	end
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