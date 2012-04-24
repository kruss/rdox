require "rdox/rdox"

class InfoTask < BaseTask
  
  def initialize(document)
    super("info", nil, document)
  end
  
  def run()
    dump(@document, "")
  end
  
private

	def dump(element, intent)
		info = "#{element.title}"
		if element.keys[:description] != nil then
			info << " (#{element.keys[:description]})"
		end
		if !intent.eql?("") then
			puts "#{intent}|- #{info}"
		else
			puts "#{info}"
		end
		element.childs.each do |child|
			dump(child, "#{intent}  ")
		end
	end
  
end