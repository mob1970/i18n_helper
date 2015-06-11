class I18nHelper
  def initialize
    start(ARGV)
  end

  def start(args)
    print_error(1) and return unless args_ok?(args)
    project = ARGV[0]

    ConsoleHandler.new.start_interaction do |input|
      MessageProcessor.process(input)
    end
  end

  private

  def args_ok?(args)
    args.size == 1
  end

  def print_error(error_code)
    puts error_message(error_code)
    print_help
  end

  def print_help
    puts "\tsyntax: i18n_helper project_name"
    puts ""
  end

  def error_message(error_code)
    case error_code
      when 1
        'Wrong number of parameters in I18n Helper'
      else
        'Unexpected error.'
    end
  end
end

I18nHelper.new
