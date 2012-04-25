require "rdox/rdox"
require "rdox/generated/version"
require "rdox/generated/docu"

class HelpTask < BaseTask
  
	def initialize()
    super("help", "print help", nil)
	end
  
	def run()
	    puts $VERSION
		puts $DOCU
	end
  
end