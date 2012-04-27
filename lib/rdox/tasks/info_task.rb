require "rdox/rdox"

class InfoTask < AbstractTask
  
	def initialize(document, root)
    	super("info", "print info (mode=[none]|tags|details)", document, root, [ :mode ])
	end
  
	def run()
		@show_tags = @args.mode != nil && @args.mode.eql?("tags") ? true : false
		@show_details = @args.mode != nil && @args.mode.eql?("details") ? true : false

		dump(@document, 0)
	end
  
private

	def dump(element, level)
		info = ""
		if element.root? then
			info << "[ #{element.name} ]"
		else
			info << "#{element.index} [ #{element.name} ]"
		end
		if @show_tags && element.tags.size > 0 then
			info << " => #{element.tags.join(", ")}"
		elsif @show_details && element.description != nil then
			info << " #{element.description}"
		end
		if element.root? then
			puts "#{info}"
		else
			intent = ""
			for i in 1..level do
				intent << "  |"
			end
			puts "#{intent}- #{info}"
		end
		element.childs.each do |child|
			dump(child, level+1)
		end
	end
  
end