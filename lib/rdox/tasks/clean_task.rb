require "rdox/rdox"

class CleanTask < AbstractTask
  
	def initialize(document, root)
    	super("clean", "clean sources", document, root)
	end
  
	def run()
		puts "clean: #{$SOURCE}/"
		files = FileList.new("#{$SOURCE}/**/*.html")
		files.each do |file|
			FileUtils.rm_rf(file)
		end
		puts "removed: #{files.size} files"
	end
  
end