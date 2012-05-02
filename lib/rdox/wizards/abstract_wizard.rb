
class AbstractWizard

	def run()
		run_wizard()
	end
	
protected

	def run_wizard()
		raise NotImplementedError.new()
	end
	
	def read(info)
		puts "> #{info}:"  
		STDOUT.flush  
		return gets.chomp   
	end

end