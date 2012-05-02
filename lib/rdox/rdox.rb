require "rake"
require "rdox/generated"
require "rdox/core/model"
require "rdox/core/model_printer"
require "rdox/tasks/abstract_task"
require "rdox/tasks/info_task"
require "rdox/tasks/clean_task"
require "rdox/tasks/check_task"
require "rdox/tasks/build_task"
require "rdox/builder/abstract_builder"
require "rdox/builder/content_builder"
require "rdox/builder/map_builder"
require "rdox/builder/print_builder"

$SOURCE = "src"

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