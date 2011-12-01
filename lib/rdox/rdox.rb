
class RDox

	def initialize(logger, options)
		@logger = logger
		@options = options
	end

	def run()
		@logger.info("#{$AppName} (#{$AppVersion})")
		if @options.root != nil then
			@logger.debug("in: #{Dir.getwd}")
			run_rdox(@options.root, @options.continous)
		else
			@logger.info("missing parameter,- try: #{$AppName} --help")
		end
		@logger.info("bye.")
	end
	
private

	def run_rdox(root, continous)
		while true
			@logger.info("scan: #{root}")
			@document_mgr.scan()
			rdoxs = @document_mgr.rdoxs.size
			@logger.info("=> #{rdoxs} rdoxs")
			if rdoxs > 0 then
				@document_mgr.compile()
			else
				raise "no rdox at: #{root}"
			end
			if !continous then
				break
			else
				hash = 
				while !@change_mgr.changed?(@document_mgr.get_rdox_files(root))
					sleep 100
				end
			end
		end
	end
	
end