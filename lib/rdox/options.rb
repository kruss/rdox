require "optparse"
require "pathname"

class Options

	def initialize()
		@options = {}
		set_options()
	end
	
	def root()
		return @options[:root]
	end

	def continous?()
		return @options[:continous]
	end
	
	def verbose?()
		return @options[:verbose]
	end
	
private

	def set_options()
		optparse = OptionParser.new do |options|
			options.banner = $AppName+" <folder> [options ...]"	
			
			@options[:continous] = false
				options.on("-c", "--continous", "Run in continous mode") do
				@options[:continous] = true
			end
			
			@options[:verbose] = false
				options.on("-v", "--verbose", "Print additional logging") do
				@options[:verbose] = true
			end
	    
			options.on("-h", "--help", "Display this screen") do
				puts options
				exit(0)
			end
			
		end
		optparse.parse!
		
		@options[:root] = nil
		if ARGV.size == 1 then
			@options[:root] = clean_path(ARGV[0])
		end
	end
	
	def clean_path(path)
		if path == "." then
			return Dir.getwd
		elsif path == ".." then
			return Pathname.new(Dir.getwd+"/..").cleanpath.to_s
		else
			return Pathname.new(path.gsub(/\\/, "/")).cleanpath.to_s
		end
	end

end