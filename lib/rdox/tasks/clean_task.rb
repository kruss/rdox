require "rdox/rdox"

class CleanTask < BaseTask
  
	def initialize(document)
    	super("clean", "clean output", document)
	end
  
	def run()
		if File.directory?($OUTPUT) then
			FileUtils.rm_rf($OUTPUT)
		end
	end
  
end