require "rdox/rdox"

class CheckTask < BaseTask
  
	def initialize(document)
    	super("check", "check sources", document)
	end
  
	def run()
		if !File.directory?($SOURCE) then
	  		FileUtils.mkdir_p($SOURCE)
	  	end
	  	
		check_css()
	    check_source(@document)    
	end
  
private
	
	def check_css()
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
		css << "h3              { font-family:'Arial,sans-serif'; font-size:11pt; font-weight:bold; } \r\n"
		css << "h4              { font-family:'Arial,sans-serif'; font-size:10pt; font-weight:bold; } \r\n"
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
	
	def check_source(element)
		source = "#{$SOURCE}/#{element.id}.rdox"
		if !File.file?(source) then
			puts "create: #{source}"
			File.open(source, 'w') { |output| 
				output.write("TODO") 
			}
		end
		element.childs.each do |child|
			check_source(child)
		end
	end
end