
class PrintBuilder < AbstractBuilder

	def initialize(date, folder)
		super(date, folder)
	end
	
	def build(element)
		source = "#{$SOURCE}/#{element.id}/content.rdox"
		target = "#{@folder}/#{element.id}/print.html"
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

	def write_title(output, element)
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		header = element.level < 4 ? element.level + 1 : 4
		output.write("<tr><td align=left><h#{header}>#{element.index} #{element.name}</h#{header}></td>\r\n")
		if element.description != nil then
			output.write("<td align=right valign=top><i>#{element.description}</i></td>\r\n")
		end
		output.write("</tr></table>\r\n")
		output.write("<hr>\r\n")
	end
	
end