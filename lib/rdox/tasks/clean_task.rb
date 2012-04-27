require "rdox/rdox"

class CleanTask < AbstractTask
  
	def initialize(document, root)
    	super("clean", "clean output", document, root)
	end
  
	def run()
		if File.directory?($OUTPUT) then
			puts "remove: #{$OUTPUT}/"
			FileUtils.rm_rf($OUTPUT)
		end
		
		files = FileList.new("#{$SOURCE}/**/*.html")
		files.each do |file|
			puts "remove: #{file}"
			FileUtils.rm_rf(file)
		end
	end
  
end