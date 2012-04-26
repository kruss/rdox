require "rdox/rdox"

class BuildTask < BaseTask
  
	def initialize(document)
    	super("build", "build document", document)
	end
  
	def run()		
	    if File.directory?($OUTPUT) then
	    	FileUtils.rm_rf($OUTPUT)
	  	end
	  	FileUtils.mkdir_p($OUTPUT)

	    build_content(@document)
	    build_map(@document)
	    #build_print(@document)
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
	
	def build_map(element)
		target = "#{$OUTPUT}/#{element.id}-map.html"
		puts "build: #{target}"
		File.open(target, 'w') { |output| 
			output.write("<html><title>#{element.name} - Map</title><head>\r\n") 
			output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
			output.write(get_css)
			output.write("</head><body>\r\n")
			output.write("<hr>&lt; <a href='#{element.id}.html'>#{element.name}</a><hr>\r\n")
			output.write("<h1>#{element.name} - Map</h1>\r\n") 
			output.write("<hr><p>\r\n")
			if element.childs? then
				write_map(output, element)
			else
				output.write("<i>empty</i>\r\n")
			end
			output.write("</p><hr>#{$GEM} (#{$VERSION})<hr>\r\n")
			output.write("</body></html>\r\n") 
		}
	end
	
	def write_map(output, element)
		output.write("<ol>\r\n")
		element.childs.each do |child|
			output.write("<li><a href='#{child.id}.html'>#{child.name}</a></li>\r\n")
			if child.childs? then
				write_map(output, child)
			end
		end
		output.write("</ol>\r\n")
	end
		
	def write_content_header(output, element)
		output.write("<html><title>#{element.name}</title><head>\r\n") 
		output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
		output.write(get_css)
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
		if element.keys[:description] != nil then
			output.write("<i>#{element.keys[:description]}</i>\r\n") 
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
	
	def write_content_footer(output, element, date)
		output.write("</p>\r\n")
		output.write("<hr><table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		output.write("<tr><td align=left>#{element.author}</td>\r\n")
		output.write("<td align=right>#{date.strftime("%Y-%m-%d %H:%M:%S")}</td></tr>\r\n")
		output.write("</table><hr>\r\n")
		output.write("</body></html>\r\n") 
	end
	
	def get_css
		css =  "<style type='text/css'> \r\n"
		css << "  h1				{ font-family:'Arial,sans-serif'; font-size:14pt; font-weight:bold; } \r\n"
		css << "  h2				{ font-family:'Arial,sans-serif'; font-size:12pt; font-weight:bold; } \r\n"
		css << "  h3				{ font-family:'Arial,sans-serif'; font-size:11pt; font-weight:bold; } \r\n"
		css << "  h4				{ font-family:'Arial,sans-serif'; font-size:10pt; font-weight:bold; } \r\n"
		css << "  body				{ font-family:'Arial,sans-serif'; font-size:8pt; } \r\n"
		css << "  p,td,li			{ font-family:'Arial,sans-serif'; font-size:8pt; } \r\n"
		css << "  a:link 			{ color:blue; text-decoration:none; } \r\n"
		css << "  a:visited 		{ color:blue; text-decoration:none; } \r\n"
		css << "  a:focus 			{ color:orange; text-decoration:none; } \r\n"
		css << "  a:hover 			{ color:orange; text-decoration:none; } \r\n"
		css << "  a:active 			{ color:orange; text-decoration:none; } \r\n"
		css << "  .small 			{ font-size:7pt; } \r\n"
		css << "</style> \r\n"
		return css
	end
  
end