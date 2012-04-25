require "rdox/rdox"

class InfoTask < BaseTask
  
	def initialize(document)
    	super("info", "print document info (flag: <none>|tags|details)", document, [ :flag ])
	end
  
	def run()
		@flag = @parameters.flag
		dump(@document, 0)
	end
  
private

	def dump(element, level)
		info = "[ #{element.title} ]"
		if @flag != nil && @flag.eql?("details") && element.keys[:description] != nil then
			info << " #{element.keys[:description]}"
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