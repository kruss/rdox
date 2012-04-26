require "rdox/rdox"

class CleanTask < BaseTask
  
	def initialize(document)
    	super("clean", "clean output", document)
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