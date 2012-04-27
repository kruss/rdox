require "rdox/rdox"

class InfoTask < AbstractTask
  
	def initialize(document, root)
    	super("info", "print info (mode=[none]|tags|details)", document, root, [ :mode ])
	end
  
	def run()
		printer = ModelPrinter.new(@document)
		if @args.mode != nil && @args.mode.eql?("tags") then
			printer.print(:tags)
		elsif @args.mode != nil && @args.mode.eql?("details") then
			printer.print(:details)
		else
			printer.print()
		end
	end
  
end