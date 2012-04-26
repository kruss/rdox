
class MapBuilder

	def build(element)
		target = "#{$OUTPUT}/#{element.id}/map.html"
		puts "build: #{target}"
		if !File.directory?(File.dirname(target)) then
	  		FileUtils.mkdir_p(File.dirname(target))
	  	end
		File.open(target, 'w') { |output| 
			output.write("<html><title>#{element.name} (Map)</title><head>\r\n") 
			output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
			output.write("<link rel='stylesheet' type='text/css' href='../style.css'>\r\n")
			output.write("</head><body>\r\n")
			output.write("<hr>&lt; <a href='../#{element.id}/index.html'>#{element.name}</a><hr>\r\n")
			output.write("<h1>#{element.name} - Map</h1>\r\n") 
			output.write("<hr><p>\r\n")
			write_map(output, element)
			output.write("</p><hr>#{$GEM} (#{$VERSION})<hr>\r\n")
			output.write("</body></html>\r\n") 
		}
	end
	
private

	def write_map(output, element)
		output.write("<ul>\r\n")
		element.childs.each do |child|
			output.write("#{child.index}")
			output.write(" <b><a href='../#{child.id}/index.html'>#{child.name}</a></b>\r\n")
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