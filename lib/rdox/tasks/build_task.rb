require "rdox/rdox"

class BuildTask < AbstractTask
  
	def initialize(document, root)
    	super("build", "build document (mode=[debug]|release)", document, root, [ :mode ])
	end
  
	def run()		
	  	release = @args.mode != nil && @args.mode.eql?("release") ? true : false
		date = Time.new
	  	if release then
	  		folder = "release_#{date.strftime("%Y-%m-%d_%H-%M-%S")}"
			copy_sources(folder)
			build_sources(date, folder)
		else
			build_sources(date, $SOURCE)
		end
	end
	
private

	def copy_sources(folder)
	  	files = FileList.new("#{$SOURCE}/**/*.*")
		files.exclude("#{$SOURCE}/**/*.rdox")
		files.each do |file|
			path = "#{file}"
			target = "#{folder}#{path[$SOURCE.length, path.length]}"
			puts "copy: #{target}"
			if !File.directory?(File.dirname(target)) then
		  		FileUtils.mkdir_p(File.dirname(target))
		  	end
			FileUtils.cp(file, target)
		end
	end
	
	def build_sources(date, folder)
	    PlainBuilder.new(date, folder).build(@document)
	end
  
end