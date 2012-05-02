
class Page 

	def initialize(options, &block)
		@parent = nil
		@childs = Array.new
		@options = options
		
		instance_eval &block if block_given?
	end
	attr_accessor :parent
	attr_accessor :childs
	attr_accessor :options
	
	def name
		return @options[:name] != nil ? @options[:name] : "UNDEFINED"
	end
	
	def description
		return get_option(:description)
	end
	
	def author
		return get_option(:author)
	end
	
	def tags
		return get_option_values(:tags) << :all
	end
	
	def todo?
		return tags.include[:todo]
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
		@childs.each do |child|
			child.parent = self
			child.pack()
		end
	end
	
protected

	def get_option(key)
		if @options[key] != nil then
			return @options[key]
		elsif @parent != nil then
			return @parent.get_option(key)
		else
			return nil
		end
	end
	
	def get_option_values(key)
		values = Array.new
		collect_option_values(self, values, key)
		parent = @parent
		while parent != nil do
			collect_option_values(parent, values, key)
			parent = parent.parent
		end	
		return values
	end
	
	def collect_option_values(element, values, key)
		if element.options[key] != nil then
			element.options[key].each do |value|
					if !values.include?(value) then
						values << value
					end				
			end
		end
	end
	
end