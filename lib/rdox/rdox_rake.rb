require "rdox/rdox"

class RDox
	include Rake::DSL if defined?(Rake::DSL)

	def initialize(document, root)
		document.pack()
		
	    info = InfoTask.new(document, root).init()
	    task :default => info.name 
	    
	    clean = CleanTask.new(document, root).init()
	    check = CheckTask.new(document, root).init()
	    
	    build = BuildTask.new(document, root).init()
	    task build.name => [ info.name, clean.name, check.name ] 
	end
end