require "rdox/rdox"

class RdoxGem

	def initialize()
		@commands = Array.new
		@commands << CreateCommand.new()	
	end
	
	def run()
		puts "\n\t>>> #{$GEM} (#{$VERSION}) build #{$DATE} <<<\n\n"
		if ARGV[0] == nil then
			puts $HELP
			puts "\n=> commands\n"
			@commands.each do |command|
				command.init()
				command.help()
			end	
		else
			command = get_command(ARGV[0]) 
			if command != nil then
				command.init()
				command.run()
				exit(0)	
			else
				puts "=> unknown command !!!"
			end
		end
		exit(-1)
	end
	
private

	def get_command(name)
	    @commands.each do |command|
	      if command.name.eql?(name) then
	        return command
	      end
	    end
	    return nil
	end
end
