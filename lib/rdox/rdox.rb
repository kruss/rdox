require "rake"
require "rdox/generated.rb"
require "rdox/core/model"
require "rdox/core/content_builder"
require "rdox/core/map_builder"
require "rdox/core/print_builder"
require "rdox/tasks/base_task"
require "rdox/tasks/info_task"
require "rdox/tasks/check_task"
require "rdox/tasks/clean_task"
require "rdox/tasks/build_task"

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