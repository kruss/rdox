require "rdox/rdox"

class BuildTask < BaseTask
  
  def initialize(document)
    super("build", "build the document", document)
  end
  
  def run()
	setup()
    check(@document)    
    build(@document)
  end
  
private

	def setup()
		if !File.directory?($SOURCE) then
	  		FileUtils.mkdir_p($SOURCE)
	  	end
	    if File.directory?($OUTPUT) then
	    	FileUtils.rm_rf($OUTPUT)
	  	end
	  	FileUtils.mkdir_p($OUTPUT)
	end
	
	def check(element)
		source = "#{$SOURCE}/#{element.target()}.rdox"
		if !File.file?(source) then
			puts "creating: #{source}"
			File.open(source, 'w') { |f| 
				f.write("TODO: add content for '#{element.title}'") 
			}
		end
		element.childs.each do |child|
			check(child)
		end
	end
	
	def build(element)
	    source = "#{$SOURCE}/#{element.target()}.rdox"
		target = "#{$OUTPUT}/#{element.target()}.html"
		puts "building: #{target}"
		File.open(target, 'w') { |f| 
			f.write("<html>") 
			f.write("<h1>#{element.title}</h1>") 
			f.write("</html>") 
		}
		element.childs.each do |child|
			build(child)
		end
	end
  
end