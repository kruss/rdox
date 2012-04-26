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

	    build(@document)
	end
  
private
	
	def build(element)
	    source = "#{$SOURCE}/#{element.id}.rdox"
		target = "#{$OUTPUT}/#{element.id}.html"
		puts "build: #{target}"
		date = File::mtime(source)
		File.open(source, "r") { |input|
			File.open(target, 'w') { |output| 
				write_header(output, element)
				write_body(input, output)
				write_footer(output, element, date)
			}
		}
		element.childs.each do |child|
			build(child)
		end
	end
	
private

	def write_header(output, element)
		output.write("<html><title>#{element.name}</title><head>\r\n") 
		output.write("<!-- #{$NAME} (#{$VERSION}) build #{$DATE} //-->\r\n")
		output.write(get_css)
		output.write("</head><body>\r\n")  
		output.write("<hr>\r\n")
		if !element.root? then
			links = Array.new
			parent = element.parent
			while parent != nil do
				links << "<a href='#{parent.id}.html'>#{parent.name}</a>"
				parent = parent.parent
			end
			output.write("#{links.reverse.join(" &lt; ")}\r\n")
			output.write("<hr>\r\n")
		end
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
			output.write("#{links.join(" / ")}\r\n")
			output.write("<hr>\r\n")
		end
	end
	
	def write_body(input, output)
		output.write("<p>\r\n")
		output.write(input.read)
		output.write("</p>\r\n")
	end
	
	def write_footer(output, element, date)
		output.write("<hr>rDox - #{date.strftime("%Y-%m-%d %H:%M:%S")}<hr>\r\n")
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