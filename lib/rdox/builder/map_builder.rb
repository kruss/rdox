
class MapBuilder < AbstractBuilder

	def initialize(date, folder)
		super(date, folder)
	end
	
	def build(element)
		target = "#{@folder}/map.html"
		puts "build: #{target}"
		if !File.directory?(File.dirname(target)) then
	  		FileUtils.mkdir_p(File.dirname(target))
	  	end
		File.open(target, 'w') { |output| 
			write_header(output, nil, "#{element.name} - Map")
			write_title(output, element)
			output.write("<p>\r\n")
			write_map(output, element)
			output.write("</p>\r\n")
			write_footer(output, element)
		}
	end
	
private

	def write_title(output, element)
		output.write("[ <a href='javascript:history.back()'>back</a> ]\r\n")
		output.write("<hr>\r\n")
		output.write("<h1>#{element.name} - Map</h1>\r\n")
		output.write("<hr>\r\n")	
	end

	def write_map(output, element)
		output.write("<ul>\r\n")
		element.childs.each do |child|
			output.write("#{child.index}")
			output.write(" <b><a href='#{child.id}/index.html'>#{child.name}</a></b>\r\n")
			if child.description != nil then
				output.write(" - #{child.description}\r\n")
			end
			output.write("<br>\r\n")
			if child.childs? then
				write_map(output, child)
			end
		end
		output.write("</ul>\r\n")
	end
	
end