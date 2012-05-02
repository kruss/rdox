require "rake"
require "rdox/generated"
require "rdox/core/model"
require "rdox/core/model_printer"
require "rdox/core/model_serializer"
require "rdox/tasks/abstract_task"
require "rdox/tasks/info_task"
require "rdox/tasks/clean_task"
require "rdox/tasks/check_task"
require "rdox/tasks/build_task"
require "rdox/builder/abstract_builder"
require "rdox/builder/content_builder"
require "rdox/builder/map_builder"
require "rdox/builder/print_builder"
require "rdox/commands/abstract_command"
require "rdox/commands/create_command"
require "rdox/wizards/abstract_wizard"
require "rdox/wizards/create_wizard"
require "rdox/rdox_rake"
require "rdox/rdox_gem"

$SOURCE = "src"