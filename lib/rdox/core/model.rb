
class Element 

	def initialize(name, description = nil, author=nil)
		@parent = nil
		@childs = Array.new
		
		@keys = Hash.new
		@keys[:name] = name
		if description != nil then
			@keys[:description] = description
		end
		if author != nil then
			@keys[:author] = author
		end
		
		@tags = [ :all ]
	end
	attr_accessor :parent
	attr_accessor :childs
	attr_accessor :keys
	attr_accessor :tags
	
	def name
		return @keys[:name]
	end
	
	def description
		return @keys[:description]
	end
	
	def author
		return @keys[:author]
	end
	
	def root?()
		return @parent == nil
	end
	
	def childs?()
		return @childs.size > 0
	end
	
	def id()
		id = name.gsub(/\s+/, '-').downcase
		if root? then
			return "index"
		elsif !root? && @parent.root? then
			return "#{id}"
		else
			return "#{@parent.id}_#{id}"
		end
	end
	
	def pack()
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

	def initialize(name, description = nil, author=nil)
		super(name, description, author)
	end
end

class Page < Element

	def initialize(name, description = nil, author=nil)
		super(name, description, author)
	end
end