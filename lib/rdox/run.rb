require "logger"
require "rdox/rdox"
require "rdox/options"

$AppName = "rdox"
$AppVersion = "0.1.0"

options = Options.new

logger = Logger.new(STDOUT)
logger.formatter = proc { |severity, datetime, progname, msg|
  "#{datetime.strftime("%H:%M:%S")} <#{severity}>\t #{msg}\n"
}
if options.verbose? then
  logger.level = Logger::DEBUG
else
  logger.level = Logger::INFO
end
    
rdox = RDox.new(logger, options)
rdox.run