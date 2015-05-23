class ParametersHandler

  PARAMETERS = {
    :long_project => :project,
    :short_project => :project,
    :refresh_cache => :refresh_cache,
    :long_query => :query,
    :short_query => :query
  }

  def self.extract(parameters=[])
    options = []
    i=0
    while i < parameters.size do
      parameter = parameters[i]
      result = guess_parameter(parameter)
      case result
        when :long_project, :long_query
          options << Parameter.new(PARAMETERS[result], extract_value_from_long_parameter(parameter))
        when :short_project, :short_query
          i += 1
          options << Parameter.new(PARAMETERS[result], parameters[i])
        when :refresh_cache
          options << Parameter.new(PARAMETERS[result], '')
      end
      i += 1
    end

    options
  end

  private

  def self.extract_value_from_long_parameter(parameter)
    separator_position = parameter.index('=')
    separator_position ? parameter[separator_position+1, parameter.length] : ''
  end

  def self.guess_parameter(parameter)
    case parameter
      when /--project=.+/
        :long_project
      when '-p'
        :short_project
      when /-(r|-refresh-cache)/
        :refresh_cache
      when '-q'
        :short_query
      when /--query=.+/
        :long_query
      else
        nil
    end
  end
end
