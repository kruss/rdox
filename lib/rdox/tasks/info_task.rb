require "rdox/rdox"

class InfoTask < BaseTask
  
	def initialize(document)
    super("info", "print structure", document)
	end
  
	def run()
		dump(@document, 0)
	end
  
private

	def dump(element, level)
		info = "[ #{element.title} ]"
		if element.tags.size > 0 then
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