require "rdox/rdox"

class BuildTask < AbstractTask
  
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
		date = Time.new
	    ContentBuilder.new(date).build(@document)
	    MapBuilder.new(date).build(@document)	
	    PrintBuilder.new(date).build(@document)
	end
  
end