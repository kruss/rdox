require "rdox/rdox"

class BuildTask < AbstractTask
  
	def initialize(document)
    	super("build", "build document (mode=[debug]|release)", document, [ :mode ])
	end
  
	def run()		
	  	@release = @args.mode != nil && @args.mode.eql?("release") ? true : false
	  	
		copy_sources()	
		build_sources()
	end
	
private

	def copy_sources()
		if @release then
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
	end
	
	def build_sources()
		date = Time.new
		folder = @release ? $OUTPUT : $SOURCE
	    ContentBuilder.new(date, folder).build(@document)
	    MapBuilder.new(date, folder).build(@document)	
	    PrintBuilder.new(date, folder).build(@document)
	end
  
end