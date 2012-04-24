require "rake"
require "rdox/core/model"
require "rdox/tasks/base_task"
require "rdox/tasks/info_task"

class RDox
	include Rake::DSL if defined?(Rake::DSL)

	def initialize(document)
	    infoTask = InfoTask.new(document).init()
	    
	    task :default => infoTask.name 
	end
end