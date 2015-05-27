$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'fileutils'
require 'rspec'
require 'pry'

require 'handlers/parameter'
require 'handlers/parameters_handler'
require 'handlers/database_handler'
require 'utils/file_utils'

RSpec.configure do |config|
  config.order = 'random'
end


def row_exists?(project, conditions, expected)
  allow(Utils::FileUtils).to receive(:home_directory).and_return("#{File.expand_path('.')}/spec/db")
  result = DatabaseHandler.query_rows(project, conditions)

  expect(result.size).to eq(1)
  expect(result.first[:locale]).to eq(expected[:locale])
  expect(result.first[:key]).to eq(expected[:key])
  expect(result.first[:value]).to eq(expected[:value])
end
