
class ContentBuilder
	
	def build(element)
	    source = "#{$SOURCE}/#{element.id}.rdox"
		target = "#{$OUTPUT}/#{element.id}.html"
		puts "build: #{target}"
		File.open(source, "r") { |input|
			File.open(target, 'w') { |output| 
				write_header(output, element)
				output.write(input.read)
				write_footer(output, element, File::mtime(source))		
			}
		}
		element.childs.each do |child|
			build(child)
		end
	end
	
private

	def build_content(element)
	    source = "#{$SOURCE}/#{element.id}.rdox"
		target = "#{$OUTPUT}/#{element.id}.html"
		puts "build: #{target}"
		File.open(source, "r") { |input|
			File.open(target, 'w') { |output| 
				write_content_header(output, element)
				output.write(input.read)
				write_content_footer(output, element, File::mtime(source))		
			}
		}
		element.childs.each do |child|
			build_content(child)
		end
	end
		
	def write_header(output, element)
		output.write("<html><title>#{element.name}</title><head>\r\n") 
		output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
		output.write("<link rel='stylesheet' type='text/css' href='style.css'>\r\n")
		output.write("</head><body>\r\n")  
		output.write("<hr><table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		if element.root? then
			links = [ 
				"<a href='index-map.html'>Map</a>", 
				"<a href='index-print.html' target=_blank>Print</a>" 
			]
			output.write("<tr><td align=right>\r\n")
			output.write("#{links.join(" | ")}\r\n")
			output.write("</td></tr>\r\n")
		else
			links = Array.new
			parent = element.parent
			while parent != nil do
				links << "<a href='#{parent.id}.html'>#{parent.name}</a>"
				parent = parent.parent
			end
			output.write("<tr><td align=left>\r\n")
			output.write("&lt; #{links.reverse.join(" &lt; ")}\r\n")
			output.write("</td></tr>\r\n")
		end
		output.write("</table><hr>\r\n")
		output.write("<h1>#{element.name}</h1>\r\n") 
		if element.description != nil then
			output.write("<i>#{element.description}</i>\r\n") 
		end
		output.write("<hr>\r\n")
		if element.childs? then
			links = Array.new
			element.childs.each do |child|
				links << "<a href='#{child.id}.html'>#{child.name}</a>"
			end
			output.write("&gt; #{links.join(" / ")}\r\n")
			output.write("<hr>\r\n")
		end
		output.write("<p>\r\n")
	end
	
	def write_footer(output, element, date)
		output.write("</p>\r\n")
		output.write("<hr><table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		output.write("<tr><td align=left>#{element.author}</td>\r\n")
		output.write("<td align=right>#{date.strftime("%Y-%m-%d %H:%M:%S")}</td></tr>\r\n")
		output.write("</table><hr>\r\n")
		output.write("</body></html>\r\n") 
	end

end