require "rdox/rdox"

class BuildTask < BaseTask
  
	def initialize(document)
    	super("build", "build document", document)
	end
  
	def run()		
	    if File.directory?($OUTPUT) then
	    	puts "remove: #{$OUTPUT}/"
	    	FileUtils.rm_rf($OUTPUT)
	  	end
	  	FileUtils.mkdir_p($OUTPUT)
	  	puts "create: #{$OUTPUT}/"
	  	
		copy_sources()	
		build_sources()
	end
	
private

	def copy_sources()
	  	files = FileList.new("#{$SOURCE}/**/*.*")
		files.exclude("#{$SOURCE}/**/*.rdox")
		files.each do |file|
			path = "#{file}"
			target = "#{$OUTPUT}#{path[$SOURCE.length, path.length]}"
			puts "copy: #{target}"
			if !File.directory?(File.dirname(target)) then
		  		FileUtils.mkdir_p(File.dirname(target))
		  	end
			FileUtils.cp(file, target)
		end
	end
	
	def build_sources()
	    ContentBuilder.new().build(@document)
	    MapBuilder.new().build(@document)	
	    PrintBuilder.new().build(@document)
	end
  
end