require "rdox/rdox"

class InitCommand < AbstractCommand

	def initialize()
		super("init", "Create a new document")
	end
  
	def init_options()
		@parser.on("-n", "--name NAME", "Name of new document") do |param|
			@options[:name] = param
		end
		@parser.on("-p", "--path PATH", "Path of new document (optional)") do |param|
			@options[:path] = param
		end
	end
  
	def options_valid?()
		if @options[:name] != nil then
			return true
		else
			return false
		end
	end
  
	def run_command()
		puts "creating: #{@options[:name]}..."
		# TODO
	end
end
