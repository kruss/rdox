
class ContentBuilder < AbstractBuilder
	
	def initialize(date, folder)
		super(date, folder)
	end
	
	def build(element)
		if element.root? then
			create_index(element)
		end
	
	    source = "#{$SOURCE}/#{element.id}/content.rdox"
		target = "#{@folder}/#{element.id}/index.html"
		puts "build: #{target}"
		if !File.directory?(File.dirname(target)) then
	  		FileUtils.mkdir_p(File.dirname(target))
	  	end
		File.open(source, "r") { |input|
			File.open(target, 'w') { |output| 
				write_header(output, element)
				write_title(output, element)
				output.write("<p>\r\n")
				output.write(input.read)
				output.write("</p>\r\n")
				write_footer(output, element)		
			}
		}
		element.childs.each do |child|
			build(child)
		end
	end
	
private
	
	def create_index(element)
		target = "#{@folder}/index.html"
		puts "build: #{target}"
		File.open(target, 'w') { |output| 
			output.write("<html><head>\r\n")
			output.write("<meta http-equiv='REFRESH' content='0;url=#{element.id}/index.html'>\r\n")
			output.write("</head><body>\r\n")
			output.write("<a href='#{element.id}/index.html'>redirect...</a>\r\n")
			output.write("</body></html>\r\n")
		}
	end
	
	def write_title(output, element)  
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
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
			output.write("#{links.reverse.join(" &lt; ")}\r\n")
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
			output.write("#{links.join(" / ")}\r\n")
			output.write("<hr>\r\n")
		end
	end

end