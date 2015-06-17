require './lib/handlers/console_handler'
require './lib/processors/message_processor'

class I18nHelper
  def initialize
    start(ARGV)
  end

  def start(args)
    print_error(1) and return unless args_ok?(args)
    @project = ARGV[0]

    ConsoleHandler.new.start_interaction do |input|
      response = MessageProcessor.process(@project, input)
      post_process_actions(response)
      response.output
    end
  end

  private

  def post_process_actions(response)
    @project = response.output if response.setting_project?
    if response.quit?
      print_goodbye_message
      Kernel.exit
    end
  end

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

  def print_goodbye_message
    puts 'Thanks for using I18nHelper. See you next time.'
  end
end

I18nHelper.new
