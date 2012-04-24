require "rake"
require "rdox/core/model"
require "rdox/tasks/base_task"
require "rdox/tasks/help_task"
require "rdox/tasks/info_task"
require "rdox/tasks/build_task"

class RDox
	include Rake::DSL if defined?(Rake::DSL)

	def initialize(document)
		document.pack()
		
	    help = HelpTask.new().init()
	    task :default => help.name 
	    
	    InfoTask.new(document).init()
	    BuildTask.new(document).init()
	end
end