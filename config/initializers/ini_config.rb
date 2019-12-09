Encoding.default_external = 'UTF-8'
Encoding.default_internal = 'UTF-8'

require 'yaml'
require 'logger'
require 'active_support/core_ext/hash/keys'

config = YAML.safe_load(File.read(File.join(__dir__, '..', 'config.yml')))
config.each do |key, value|
  Object.const_set(key, value.deep_symbolize_keys)
end
LOGGER_INSTANCE ||= Logger.new(File.join(__dir__, '../../log', LOGGER[:file]))
