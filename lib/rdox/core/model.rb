
class Element 

	def initialize(name, options, &block)
		@parent = nil
		@childs = Array.new
		
		@keys = Hash.new
		@keys[:name] = name
		if options[:description] != nil then
			@keys[:description] = options[:description]
		end
		if options[:author] != nil then
			@keys[:author] = options[:author]
		end		
		
		if options[:tags] != nil then
			@tags = options[:tags]
		else
			@tags = Array.new
		end
		
		if block != nil then
			block.call(self)
		end
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
	
	def todo?
		return @tags.include[:todo]
	end
	
	def root?()
		return @parent == nil
	end
	
	def childs?()
		return @childs.size > 0
	end
	
	def id()
		path = [ name.gsub(/\s+/, '-').downcase ]
		parent = @parent
		while parent != nil do
			path << parent.name.gsub(/\s+/, '-').downcase
			parent = parent.parent
		end
		return path.reverse.join("/")
	end
	
	def level()
		level = 0
		parent = @parent
		while parent != nil do
			level = level + 1
			parent = parent.parent
		end
		return level
	end
	
	def index()
		index = Array.new
		current = self
		parent = @parent
		while parent != nil do
			index << parent.childs.index(current) + 1
			current = parent
			parent = parent.parent
		end
		return "#{index.reverse.join(".")}"
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

	def initialize(name, options = {})
		super(name, options)
	end
end

class Page < Element

	def initialize(name, options = {})
		super(name, options)
	end
end