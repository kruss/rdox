require "rdox/rdox"

class ModelPrinter

	def initialize(document)
		@document = document
	end
	
	def print(mode = :none)
		@mode = mode
		print_element(@document, 0)
	end
	
private

	def print_element(element, level)
		info = ""
		if element.root? then
			info << "[ #{element.name} ]"
		else
			info << "#{element.index} [ #{element.name} ]"
		end
		if @mode == :tags && element.tags.size > 0 then
			info << " => #{element.tags.join(", ")}"
		elsif @mode == :details && element.description != nil then
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
			print_element(child, level+1)
		end
	end
	
end