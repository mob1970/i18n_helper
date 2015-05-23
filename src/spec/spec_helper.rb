$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'parameter'
require 'parameters_handler'

RSpec.configure do |config|
    config.order = 'random'
end
