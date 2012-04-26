require "rdox/rdox"

class AbstractTask
  include Rake::DSL if defined?(Rake::DSL)
  
  def initialize(name, description, document, options = nil)
    @name = name
    @description = description
    @document = document
    @options = options
    @parameters = nil
  end
  
  def init()
      desc @description
      if @options == nil then
	      task @name do |t|
			info()
	        run()
	      end
      else
 	      task @name, @options do |t, args|
 	        @parameters = args
			info()
	        run()
	      end     
      end
  end
  
protected

  def info()
  	if @description != nil then
  		puts "=> #{@name}"
  	end  
  end
  
  def run()
    raise NotImplementedError.new()
  end

end