
class PrintBuilder

	def build(element)
		target = "#{$OUTPUT}/#{element.id}/print.html"
		puts "build: #{target}"
		File.open(target, 'w') { |output| 
			output.write("<html><title>#{element.name}</title><head>\r\n") 
			output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
			output.write("<link rel='stylesheet' type='text/css' href='../style.css'>\r\n")
			output.write("</head><body>\r\n")
			write_content(output, element)
			output.write("<hr>#{$GEM} (#{$VERSION})<hr>\r\n")
			output.write("</body></html>\r\n") 
		}
	end
	
private

	def write_content(output, element)
		source = "#{$SOURCE}/#{element.id}/content.rdox"
		header = element.level + 1
		if header > 4 then
			header = 4
		end
		output.write("<hr><table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		output.write("<tr><td align=left><h#{header}>#{element.name}</h#{header}></td>\r\n")
		if element.description != nil then
			output.write("<td align=right valign=top><i>#{element.description}</i></td>\r\n")
		end
		output.write("</tr></table><p>\r\n")
		File.open(source, "r") { |input|
			output.write(input.read)
		}
		output.write("</p>\r\n")
		
		element.childs.each do |child|
			write_content(output, child)
		end
	end
	
end