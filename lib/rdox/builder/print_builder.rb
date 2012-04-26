
class PrintBuilder < AbstractBuilder

	def initialize(date)
		super(date)
	end
	
	def build(element)
		target = "#{$OUTPUT}/#{element.id}/print.html"
		puts "build: #{target}"
		if !File.directory?(File.dirname(target)) then
	  		FileUtils.mkdir_p(File.dirname(target))
	  	end
		File.open(target, 'w') { |output| 
			write_header(output, element, "Print")
			write_content(output, element)
			write_footer(output, element) 
		}
	end
	
private

	def write_title(output, element)
	end
	
	def write_content(output, element, first=false)
		source = "#{$SOURCE}/#{element.id}/content.rdox"
		if !element.root? then
			output.write("<hr>\r\n")
		end
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		header = element.level < 4 ? element.level + 1 : 4
		output.write("<tr><td align=left><h#{header}>#{element.index} #{element.name}</h#{header}></td>\r\n")
		if element.description != nil then
			output.write("<td align=right valign=top><i>#{element.description}</i></td>\r\n")
		end
		output.write("</tr></table>\r\n")
		output.write("<p>\r\n")
		File.open(source, "r") { |input|
			output.write(input.read)
		}
		output.write("</p>\r\n")
		
		element.childs.each do |child|
			write_content(output, child)
		end
	end
	
end