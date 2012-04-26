require "rake"
require "rdox/generated.rb"
require "rdox/core/model"
require "rdox/tasks/abstract_task"
require "rdox/tasks/info_task"
require "rdox/tasks/check_task"
require "rdox/tasks/clean_task"
require "rdox/tasks/build_task"
require "rdox/builder/abstract_builder"
require "rdox/builder/content_builder"
require "rdox/builder/map_builder"
require "rdox/builder/print_builder"

$SOURCE = "src"
$OUTPUT = "html"

class RDox
	include Rake::DSL if defined?(Rake::DSL)

	def initialize(document)
		document.pack()
		
	    info = InfoTask.new(document).init()
	    task :default => info.name 
	    
	    check = CheckTask.new(document).init()
	    clean = CleanTask.new(document).init()
	    
	    build = BuildTask.new(document).init()
	    task build.name => [ info.name, check.name, clean.name ] 
	end
end