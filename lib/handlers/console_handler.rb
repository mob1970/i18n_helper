class ConsoleHandler
  LOGOUT_MESSAGE = 'quit|exit'

  def start_interaction
    input = ask_for_input
    while (input.strip !~ /#{LOGOUT_MESSAGE}/)
      print_output yield input
      input = ask_for_input
    end
  end

  def ask_for_input
    print '> '
    gets.chomp
  end

  def print_output(message)
    puts message
  end
end
