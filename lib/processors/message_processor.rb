class MessageProcessor
  def self.process(project, message)
    case message
    when /set project (.+)/
      project = $1.strip
      #change_project($1)
    when 'refresh_cache'
      refresh_cache(project)
    when /query (.+)/
      query_information(project, $1)
    else
      'Unknown action'
    end
  end

  private

  #def change_project(message)
  #end

  def refresh_cache(project)
  end

  def query_information(project, message)
  end
end
