require "rdox/rdox"

class CheckTask < BaseTask
  
	def initialize(document)
    	super("check", "check sources", document)
	end
  
	def run()
		@date = Time.new
		if !File.directory?($SOURCE) then
	  		FileUtils.mkdir_p($SOURCE)
	  	end
	  	
	    check(@document)    
	end
  
private
	
	def check(element)
		source = "#{$SOURCE}/#{element.id}.rdox"
		if !File.file?(source) then
			puts "create: #{source}"
			File.open(source, 'w') { |output| 
				output.write("TODO") 
			}
		end
		element.childs.each do |child|
			check(child)
		end
	end
end