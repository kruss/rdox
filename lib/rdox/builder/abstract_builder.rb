
class AbstractBuilder

	def initialize(date, folder)
		@date = date
		@folder = folder
	end
	
	def build(page)
		if page.root? then
			puts "build: #{page.name}"
			create_redirect(page, "#{@folder}/index.html")
			create_map(page, "#{@folder}/map.html")
		else
			puts "build: #{page.index} #{page.name}"
		end
		
	    source = "#{$SOURCE}/#{page.id}/content.rdox"
		create_page(page, source, "#{@folder}/#{page.id}/index.html")
		create_print(page, source, "#{@folder}/#{page.id}/print.html")

		page.childs.each do |child|
			build(child)
		end
	end
	
protected

	def root_link(page)
		back = ""
		for i in 0..page.level
			back << "../"
		end
		return back
	end
	
	def check_folder(file)
		if !File.directory?(File.dirname(file)) then
	  		FileUtils.mkdir_p(File.dirname(file))
	  	end
	end
	
	def create_redirect(page, file)
		check_folder(file)
		File.open(file, 'w') { |output| 
			output.write("<html><head>\r\n")
			output.write("<meta http-equiv='REFRESH' content='0;url=#{page.id}/index.html'>\r\n")
			output.write("<link rel='stylesheet' type='text/css' href='style.css'>\r\n")
			output.write("</head><body>\r\n")
			output.write("<a href='#{page.id}/index.html'>redirect...</a>\r\n")
			output.write("</body></html>\r\n")
		}
	end
	
	def create_map(page, file)
		check_folder(file)
		File.open(file, 'w') { |output| 
			write_header(output, nil, "#{page.name} - Map")
			output.write("<hr>\r\n")
			output.write("[ <a href='javascript:history.back()'>back</a> ]\r\n")
			write_title(output, nil, "#{page.name} - Map")
			write_map(output, page)
			write_footer(output, page)	
		}		
	end
	
	def write_map(output, page)
		output.write("<ul>\r\n")
		page.childs.each do |child|
			output.write("#{child.index}")
			output.write(" <b><a href='#{child.id}/index.html'>#{child.name}</a></b>\r\n")
			if child.description != nil then
				output.write(" - #{child.description}\r\n")
			end
			output.write("<br>\r\n")
			if child.childs? then
				write_map(output, child)
			end
		end
		output.write("</ul>\r\n")
	end
	
	def create_page(page, source, file)
		check_folder(file)
		File.open(source, "r") { |input|
			File.open(file, 'w') { |output| 
				write_page(page, input, output)
			}
		}	
	end
	
	def write_page(page, input, output)
		write_header(output, page, page.name)
		write_top_navi(output, page)
		write_title(output, page, "#{page.index} #{page.name}")
		write_child_navi(output, page)
		write_content(input, output)
		write_footer(output, page)
	end
	
	def create_print(page, source, file)
		check_folder(file)
		File.open(source, "r") { |input|
			File.open(file, 'w') { |output| 
				write_header(output, page, "#{page.name} [Print]")
				if !page.root? then
					output.write("<hr>\r\n")
					paths = Array.new
					parent = page.parent
					while parent != nil do
						paths << parent.name
						parent = parent.parent
					end
					output.write("#{paths.reverse.join(" &lt; ")}\r\n")
				end
				write_title(output, page, "#{page.index} #{page.name}")
				write_content(input, output)
				write_footer(output, page)	
			}
		}		
	end
	
	def write_header(output, page, title)
		output.write("<html><title>#{title}</title>\r\n") 
		output.write("<head>\r\n") 
		output.write("<!-- #{$GEM} (#{$VERSION}) build #{$DATE} //-->\r\n")
		if page != nil then
			output.write("<link rel='stylesheet' type='text/css' href='#{root_link(page)}style.css'>\r\n")
		else
			output.write("<link rel='stylesheet' type='text/css' href='style.css'>\r\n")
		end
		output.write("</head><body>\r\n") 
	end 

	def write_top_navi(output, page, title)
		raise NotImplementedError.new()
	end
	
	def write_title(output, page, title)
		raise NotImplementedError.new()
	end
	
	def write_child_navi(output, page, title)
		raise NotImplementedError.new()
	end
	
	def write_content(input, output)
		output.write("<p>\r\n")
		output.write(input.read)
		output.write("</p>\r\n")
	end
	
	def write_footer(output, page)
		output.write("<hr>\r\n")
		output.write("<table width=100% border=0 cellspacing=0 cellpadding=0>\r\n")
		output.write("<tr><td align=left class=small>#{page.author}</td>\r\n")
		output.write("<td align=right class=small>#{@date.strftime("%Y-%m-%d")}</td></tr>\r\n")
		output.write("</table>\r\n")
		output.write("<hr>\r\n")
		output.write("</body></html>\r\n") 
	end
end