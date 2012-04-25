require "rdox/rdox"
require "rdox/generated/version.rb"
require "rdox/generated/help.rb"

class HelpTask < BaseTask
  
	def initialize()
    super("help", "print help", nil)
	end
  
	def run()
	    puts "\n\t#{$VERSION}\n\n"
		puts $HELP
	end
  
end