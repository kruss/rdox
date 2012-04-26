require "rdox/rdox"

class BuildTask < BaseTask
  
	def initialize(document)
    	super("build", "build document", document)
	end
  
	def run()		
	    if File.directory?($OUTPUT) then
	    	FileUtils.rm_rf($OUTPUT)
	  	end
	  	FileUtils.mkdir_p($OUTPUT)
	  	
		copy_sources()	
		build_sources()
	end
	
private

	def copy_sources()
	  	files = FileList.new("#{$SOURCE}/*.*")
		files.exclude("#{$SOURCE}/*.rdox")
		files.each do |file|
			target = "#{$OUTPUT}/#{File.basename(file)}"
			puts "build: #{target}"
			FileUtils.cp(file, target)
		end
	end
	
	def build_sources()
	    ContentBuilder.new().build(@document)
	    MapBuilder.new().build(@document)	
	end
  
end