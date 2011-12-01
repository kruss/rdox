
class RDox

	def initialize(logger, options)
		@logger = logger
		@options = options
	end

	def run()
		@logger.info("#{$AppName} (#{$AppVersion})")
		@logger.debug("in: #{Dir.getwd}")
		if @options.root != nil then
			run_rdox()
		else
			@logger.info("missing parameter,- try: #{$AppName} --help")
		end
		@logger.info("bye.")
	end
	
private

	def run_rdox()
		@logger.info("root: #{@options.root}")
	end
	
end