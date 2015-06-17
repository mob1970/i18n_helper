require './lib/handlers/database_handler'
require './lib/formatters/output_formatter'
require './lib/utils/file_utils'

class MessageProcessor

  def self.process(project, message)
    case message.strip
      when /set project (.+)/
        MessageProcessorResult.new(MessageProcessorResult::SET_PROJECT, $1.strip)
      when 'create database'
        create_database(project)
        MessageProcessorResult.new(MessageProcessorResult::CREATE_DATABASE, MessageProcessorResult::CREATE_DATABASE)
      when 'refresh cache'
        refresh_cache(project)
        MessageProcessorResult.new(MessageProcessorResult::REFRESH_CACHE, MessageProcessorResult::REFRESH_CACHE)
      when /query (.+)/
        query_information(project, $1.strip)
        MessageProcessorResult.new(MessageProcessorResult::QUERY, OutputFormatter::format(query_information(project, $1)))
      when 'quit', 'logout'
        MessageProcessorResult.new(MessageProcessorResult::QUIT, MessageProcessorResult::QUIT)
      else
        MessageProcessorResult.new(MessageProcessorResult::UNKNOWN_ACTION, MessageProcessorResult::UNKNOWN_ACTION)
    end
  end

  private

  def self.create_database(project)
    Utils::FileUtils::create_home_directory unless Utils::FileUtils::file_exist?(Utils::FileUtils::home_directory)
    DatabaseHandler::create_database(project)
  end

  def self.refresh_cache(project)
    DatabaseHandler::delete(project)
    # data insertion here ...
  end

  def self.query_information(project, query)
    DatabaseHandler::query_rows(project, query)
  end
end

class MessageProcessorResult
  SET_PROJECT     = 'set project'
  REFRESH_CACHE   = 'refresh cache'
  QUERY           = 'query'
  UNKNOWN_ACTION  = 'unknown action'
  QUIT            = 'quit'
  LOGOUT          = 'logout'
  CREATE_DATABASE = 'create database'

  attr_reader :action, :output

  def initialize(action, output=nil)
    @action = action
    @output = output
  end

  def setting_project?
    @action == SET_PROJECT
  end

  def refreshing_cahce?
    @action == REFRESH_CACHE
  end

  def querying?
    @action == QUERY
  end

  def unknown_action?
    @action == UNKNOWN_ACTION
  end

  def create_database?
    @action == CREATE_DATABASE
  end

  def quit?
    @action == QUIT || @action == LOGOUT
  end
end
