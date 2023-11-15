# frozen_string_literal: true

require 'rs_api'

loop do
  puts 'Lookup player? Or Compare 2 players?'.yellow
  choice = gets.strip

  case choice.downcase
  when 'l'
    print 'Enter player name: '.yellow
    player_name = gets.strip

    service = RsApi::PlayerExperience.new(player_name)
    service.display
  when 'c'
    print 'Enter first player name: '.yellow
    player_one = gets.strip
    print 'Enter second player name: '.yellow
    player_two = gets.strip

    service = RsApi::PlayerCompare.new(player_one, player_two)
    service.display
  when 'e', 'exit', 'q'
    break
  else
    puts "Invalid choice #{choice}".red
    puts 'Press \'h\' for help'.yellow
  end
end
