require "rdox/rdox"

class BaseTask
  include Rake::DSL if defined?(Rake::DSL)
  
  def initialize(name, description, document)
    @name = name
    @description = description
    @document = document
  end
  
  def init()
      desc @description
      task @name do |t|
      	if @description != nil then
      		puts ">>> #{@description}"
      	end
        run()
      end
  end
  
protected

  def run()
    raise NotImplementedError.new()
  end

end