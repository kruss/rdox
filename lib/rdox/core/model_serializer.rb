require "rdox/rdox"

class ModelSerializer

	def initialize(document)
		@document = document
	end
	
	def serialize(file)
		puts "=> serialize: #{file}"
		if !File.directory?(File.dirname(file)) then
	  		FileUtils.mkdir_p(File.dirname(file))
	  	end
		File.open(file, 'w') { |output|
			output.write("require \"rdox/rdox\"\r\n")
			output.write(serialize_element(@document, ""))
			output.write("\r\n\r\nRDox.new(root, File.dirname(__FILE__))")
		}
	end
	
private

	def serialize_element(element, serialized)
		serialized << "\r\n#{intent(element)}"
		if element.level == 0 then
			serialized << "root = Page.new("
		else
			serialized << "page.childs << Page.new("
		end
		if element.options.keys.size > 0 then
			serialized << "\r\n#{intent(element)}"
			lines = Array.new
			keys = element.options.keys.sort
			keys.each do |key|
				if key == :tags && element.options[key].size() >  0 then
					lines << "\t:#{key} => #{element.options[key]}"
				else
					lines << "\t:#{key} => \"#{element.options[key]}\""				
				end
			end
			lines.sort!
			serialized << lines.join(",\r\n#{intent(element)}")
		end
		serialized << "\r\n#{intent(element)})"
		if element.childs? then
			serialized << " do |page|"
			element.childs.each do |child|
				serialize_element(child, serialized)
			end
			serialized << "\r\n#{intent(element)}end"
		end
		return serialized
	end
	
	def intent(element)
		intent = ""
		for i in 1..element.level
			intent << "\t"
		end
		return intent		
	end
	
end