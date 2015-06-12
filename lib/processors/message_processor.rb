class MessageProcessor
  SET_PROJECT   = 'set project'
  REFRESH_CACHE = 'refresh cache'
  QUERY         = 'query'

  def self.process(project, message)
    case message.strip
      when /set project (.+)/
        MessageProcessorResult.new(SET_PROJECT, $1.strip)
      when 'refresh cache'
        refresh_cache(project)
        MessageProcessorResult.new(REFRESH_CACHE)
      when /query (.+)/
        MessageProcessorResult.new(QUERY, query_information(project, $1))
      else
        'Unknown action'
    end
  end

  private

  #def change_project(message)
  #end

  def self.refresh_cache(project)
    DatabaseHandler::delete(project)
    # data insertion here ...
  end

  def self.query_information(project, query)
    DatabaseHandler::query_rows(project, query)
  end
end

class MessageProcessorResult
  attr_reader :action, :output

  def initialize(action, output=nil)
    @action = action
    @output = output
  end
end
