require "rdox/rdox"

class HelpCommand < AbstractCommand

	def initialize()
		super("help", "#{$NAME} tutorial")
	end
  
	def run_command()
		puts $HELP
	end
end
