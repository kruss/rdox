
class AbstractBuilder

	def initialize(date, folder)
		@date = date
		@folder = folder
	end
	
	def build(element)
		raise NotImplementedError.new()
	end
	
protected

	def back_link(element)
		back = ""
		for i in 0..element.level
			back << "../"
		end
		return back
	end
	
	def write_header(output, element, title = nil)
		output.write("<html>\r\n")
		if element != nil then
			output.write("<title>#{element.name}</title>\r\n") 
		elsif title != nil then
			output.write("<title>#{title}</title>\r\n") 
		end
		output.write("<head>\r\n") 
		output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
		output.write("<link rel='stylesheet' type='text/css' href='#{element != nil ? back_link(element) : ""}style.css'>\r\n")
		output.write("</head><body>\r\n") 
		output.write("<hr>\r\n")
	end 
	
	def write_footer(output, element)
		output.write("<hr>\r\n") 
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		output.write("<tr><td align=left>#{element.author}</td>\r\n")
		output.write("<td align=right>#{@date.strftime("%Y-%m-%d")}</td></tr>\r\n")
		output.write("</table>\r\n")
		output.write("<hr></body></html>\r\n") 
	end
end