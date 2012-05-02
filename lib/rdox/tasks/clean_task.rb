require "rdox/rdox"

class CleanTask < AbstractTask
  
	def initialize(document, root)
    	super("clean", "clean sources", document, root)
	end
  
	def run()
		files = FileList.new("#{$SOURCE}/**/*.html")
		files.each do |file|
			puts "remove: #{file}"
			FileUtils.rm_rf(file)
		end
	end
  
end