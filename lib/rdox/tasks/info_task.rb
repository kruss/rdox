require "rdox/rdox"

class InfoTask < AbstractTask
  
	def initialize(document)
    	super("info", "print info (flag: <none>|tags|details)", document, [ :flag ])
	end
  
	def run()
		@flag = @parameters.flag
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
		if @flag != nil && @flag.eql?("details") && element.description != nil then
			info << " #{element.description}"
		end
		if @flag != nil && @flag.eql?("tags") && element.tags.size > 0 then
			info << " => #{element.tags.join(", ")}"
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