require "rake"
require "rdox/core/model"
require "rdox/tasks/base_task"
require "rdox/tasks/help_task"
require "rdox/tasks/info_task"
require "rdox/tasks/clean_task"
require "rdox/tasks/build_task"

$SOURCE = "src"
$OUTPUT = "html"

class RDox
	include Rake::DSL if defined?(Rake::DSL)

	def initialize(document)
		document.pack()
		
		help = HelpTask.new().init()
	    info = InfoTask.new(document).init()
	    task :default => info.name 
	    
	    clean = CleanTask.new(document).init()
	    build = BuildTask.new(document).init()
	    task build.name => [ info.name, clean.name ] 
	end
end