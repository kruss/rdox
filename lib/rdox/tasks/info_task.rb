require "rdox/rdox"

class InfoTask < AbstractTask
  
	def initialize(document)
    	super("info", "print info (details=[none]|tags|verbose)", document, [ :details ])
	end
  
	def run()
		@show_tags = @args.details != nil && @args.details.eql?("tags") ? true : false
		@show_description = @args.details != nil && @args.details.eql?("verbose") ? true : false
		
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
		end
		if @show_description && element.description != nil then
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