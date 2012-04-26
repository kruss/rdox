require "rdox/rdox"

class CheckTask < AbstractTask
  
	def initialize(document)
    	super("check", "check sources", document)
	end
  
	def run()
		if !File.directory?($SOURCE) then
			puts "create: #{$SOURCE}/"
	  		FileUtils.mkdir_p($SOURCE)
	  	end
	  	
		create_css()
	    create_sources(@document)    
	end
  
private
	
	def create_css()
		source = "#{$SOURCE}/style.css"
		if !File.file?(source) then
			puts "create: #{source}"
			File.open(source, 'w') { |output|
				output.write(css())
			}
		end
	end
	
	def css()
		css =  "// #{$GEM} (#{$VERSION}) build #{$DATE} \r\n"
		css << "h1              { font-family:'Arial,sans-serif'; font-size:14pt; font-weight:bold; } \r\n"
		css << "h2              { font-family:'Arial,sans-serif'; font-size:12pt; font-weight:bold; } \r\n"
		css << "h3              { font-family:'Arial,sans-serif'; font-size:10pt; font-weight:bold; } \r\n"
		css << "h4              { font-family:'Arial,sans-serif'; font-size:8pt;  font-weight:bold; } \r\n"
		css << "body            { font-family:'Arial,sans-serif'; font-size:8pt; } \r\n"
		css << "p,td,li         { font-family:'Arial,sans-serif'; font-size:8pt; } \r\n"
		css << "a:link          { color:blue; text-decoration:none; } \r\n"
		css << "a:visited       { color:blue; text-decoration:none; } \r\n"
		css << "a:focus         { color:orange; text-decoration:none; } \r\n"
		css << "a:hover         { color:orange; text-decoration:none; } \r\n"
		css << "a:active        { color:orange; text-decoration:none; } \r\n"
		css << ".small          { font-size:7pt; } \r\n"
		css << "// add your own styles here... \r\n"
		return css
	end
	
	def create_sources(element)
		source = "#{$SOURCE}/#{element.id}/content.rdox"
		if !File.file?(source) then
			puts "create: #{source}"
			if !File.directory?(File.dirname(source)) then
		  		FileUtils.mkdir_p(File.dirname(source))
		  	end
			File.open(source, 'w') { |output| 
				output.write("TODO") 
			}
		end
		element.childs.each do |child|
			create_sources(child)
		end
	end
end