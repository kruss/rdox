require "rdox/rdox"

class AbstractCommand
  
	def initialize(name, description = nil)
		@name = name
		@description = description
		@parser = nil
		@options = {}
	end
	attr_accessor :name
  
	def init()
		OptionParser.new do |parser|
			@parser = parser
			if @description != nil then
				@parser.banner = "+ #{@name} -> #{@description}"
			else
				@parser.banner = "+ #{@name}"
			end
			init_options()
			@parser.parse!
		end
	end
  
	def run()
		puts "=> #{@name}"
	    if options_valid? then
	      run_command()
	    else
	    	puts "=> invalid options !!!"
	    	exit(-1)
	    end
	end
  
	def help()
		puts @parser
	end
  
protected

	def init_options()
	end
  
	def options_valid?
		return true
	end
  
	def run_command()
		raise NotImplementedError.new()
	end
  
end