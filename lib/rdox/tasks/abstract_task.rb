require "rdox/rdox"

class AbstractTask
  include Rake::DSL if defined?(Rake::DSL)
  
  def initialize(name, description, document, root, options = nil)
    @name = name
    @description = description
    @document = document
    @root = root
    @options = options
    @args = nil
  end
  
  def init()
      desc @description
      if @options == nil then
	      task @name do |t|
			run_task()
	      end
      else
 	      task @name, @options do |t, args|
 	        @args = args
			run_task()
	      end     
      end
  end
	
private

	def run_task()
		puts "=> #{@name}"
		cd @root do
        	run()
        end	
	end
  
protected
  
	def run()
		raise NotImplementedError.new()
	end

end