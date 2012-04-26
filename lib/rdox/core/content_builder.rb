
class ContentBuilder
	
	def build(element)
		if element.root? then
			redirect = "#{$OUTPUT}/index.html"
			puts "build: #{redirect}"
			File.open(redirect, 'w') { |output| 
				output.write("<html><head>\r\n")
				output.write("<meta http-equiv='REFRESH' content='0;url=#{element.id}/index.html'>\r\n")
				output.write("</head><body>\r\n")
				output.write("<a href='#{element.id}/index.html'>redirect...</a>\r\n")
				output.write("</body></html>\r\n")
			}
		end
	
	    source = "#{$SOURCE}/#{element.id}/content.rdox"
		target = "#{$OUTPUT}/#{element.id}/index.html"
		puts "build: #{target}"
		if !File.directory?(File.dirname(target)) then
	  		FileUtils.mkdir_p(File.dirname(target))
	  	end
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
		
	def write_header(output, element)
		output.write("<html><title>#{element.name}</title><head>\r\n") 
		output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
		output.write("<link rel='stylesheet' type='text/css' href='#{back_link(element)}style.css'>\r\n")
		output.write("</head><body>\r\n")  
		output.write("<hr><table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		if element.root? then
			links = [ 
				"<a href='map.html'>Map</a>", 
				"<a href='print.html' target=_blank>Print</a>" 
			]
			output.write("<tr><td align=right>\r\n")
			output.write("#{links.join(" | ")}\r\n")
			output.write("</td></tr>\r\n")
		else
			links = Array.new
			parent = element.parent
			while parent != nil do
				links << "<a href='#{back_link(element)}#{parent.id}/index.html'>#{parent.name}</a>"
				parent = parent.parent
			end
			output.write("<tr><td align=left>\r\n")
			output.write("&lt; #{links.reverse.join(" &lt; ")}\r\n")
			output.write("</td></tr>\r\n")
		end
		output.write("</table><hr>\r\n")
		output.write("<h1>#{element.index} #{element.name}</h1>\r\n") 
		if element.description != nil then
			output.write("<i>#{element.description}</i>\r\n") 
		end
		output.write("<hr>\r\n")
		if element.childs? then
			links = Array.new
			element.childs.each do |child|
				links << "<a href='#{back_link(element)}#{child.id}/index.html'>#{child.name}</a>"
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
	
	def back_link(element)
		back = ""
		for i in 0..element.level
			back << "../"
		end
		return back
	end

end