
class PlainBuilder < AbstractBuilder
	
	def initialize(date, folder)
		super(date, folder)
	end
	
protected

	def write_top_navi(output, page)
		output.write("<hr>\r\n")
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0><tr>\r\n")
		if !page.root? then
			links = Array.new
			parent = page.parent
			while parent != nil do
				links << "<a href='#{root_link(page)}#{parent.id}/index.html'>#{parent.name}</a>"
				parent = parent.parent
			end
			output.write("<td align=left>\r\n")
			output.write("#{links.reverse.join(" &lt; ")}\r\n")
			output.write("</td>\r\n")
		else
			output.write("<td>&nbsp;</td>")
		end
		links = [ 
			"<a href='#{root_link(page)}map.html'>Map</a>", 
			"<a href='print.html' target=_blank>Print</a>" 
		]
		output.write("<td align=right>\r\n")
		output.write("#{links.join(" | ")}\r\n")
		output.write("</td>\r\n")
		output.write("</tr></table>\r\n")	
	end
	
	def write_title(output, page, title)
		output.write("<hr>\r\n")
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		output.write("<tr><td align=left><h1>#{title}</h1></td>\r\n")
		if page != nil && page.description != nil then
			output.write("<td align=right valign=top><i>#{page.description}</i></td>\r\n")
		end
		output.write("</tr></table>\r\n")
		output.write("<hr>\r\n")
	end
	
	def write_child_navi(output, page)
		if page.childs? then
			links = Array.new
			page.childs.each do |child|
				links << "<a href='#{root_link(page)}#{child.id}/index.html'>#{child.name}</a>"
			end
			output.write("#{links.join(" / ")}\r\n")
			output.write("<hr>\r\n")
		end
	end

end