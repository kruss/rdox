require "rdox/rdox"

class ModelPrinter

	def initialize(document)
		@document = document
	end
	
	def print(mode = :none)
		@mode = mode
		print_element(@document)
	end
	
private

	def print_element(element)
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
			for i in 1..element.level do
				intent << "  |"
			end
			puts "#{intent}- #{info}"
		end
		element.childs.each do |child|
			print_element(child)
		end
	end
	
end