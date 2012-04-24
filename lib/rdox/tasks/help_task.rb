require "rdox/rdox"

class HelpTask < BaseTask
  
  def initialize()
    super("help", nil, nil)
  end
  
  def run()
	puts "... some help"
  end
  
end