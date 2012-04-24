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
        run()
      end
  end
  
protected

  def run()
    raise NotImplementedError.new()
  end

end