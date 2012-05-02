
class CreateWizard < AbstractWizard

	def initialize(name, path)
		@name = name
		@path = path
	end

	def run_wizard()
		folder = "#{@path}/#{@name.gsub(/\s+/, '-').downcase}"
		if File.directory?(folder) then
			raise "already existing: #{folder}"
		end
		FileUtils.mkdir_p(folder)
		
		@root = Page.new(:name => @name)
		@serializer = ModelSerializer.new(@root)
		cd folder do
			@serializer.serialize("rakefile")
		end
		
	end

end