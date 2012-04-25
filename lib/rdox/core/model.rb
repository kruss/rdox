
class Element 

	def initialize(title)
		@title = title
		@keys = Hash.new
		@tags = Array.new
		@parent = nil
		@childs = Array.new
	end
	attr_accessor :title
	attr_accessor :keys
	attr_accessor :tags
	attr_accessor :parent
	attr_accessor :childs
	
	def root?()
		return @parent == nil
	end
	
	def childs?()
		return @childs.size > 0
	end
	
	def target()
		name = @title.gsub(/\s+/, '-').downcase
		if root? then
			return "index"
		elsif !root? && @parent.root? then
			return "#{name}"
		else
			return "#{@parent.target()}_#{name}"
		end
	end
	
	def pack()
		if root? then
			@tags = [ :all ]
		end
		childs.each do |child|
			tags.each do |tag|
				if !child.tags.include?(tag) then
					child.tags << tag
				end
			end
			child.tags = child.tags.sort_by { |tag| tag.to_s }
			keys.keys.each do |key|
				if keys[key] != nil && child.keys[key] == nil then
			 		child.keys[key] = keys[key]
				end
			end
			child.parent = self
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