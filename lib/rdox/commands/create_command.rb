require "rdox/rdox"

class CreateCommand < AbstractCommand

	def initialize()
		super("create", "Create a new document")
	end
  
	def init_options()
		@parser.on("-n", "--name NAME", "Name of new document") do |param|
			@options[:name] = param
		end
		@parser.on("-p", "--path PATH", "Path to new document (optional)") do |param|
			@options[:path] = param
		end
	end
  
	def options_valid?()
		if @options[:name] != nil && !@options[:name].eql?("") then
			return true
		else
			return false
		end
	end
  
	def run_command()
		wizard = CreateWizard.new(
			@options[:name], 
			@options[:path] != nil ? @options[:path] : Dir.getwd
		)
		wizard.run
	end
end
