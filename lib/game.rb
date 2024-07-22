require("colorize")
require_relative("computer_player")
require_relative("human_player")

class Game
  PLAYER_VS_COMPUTER = 1
  PLAYER_VS_PLAYER = 1

  def start
    play_choosen_mode display_playmode
  end

  def display_playmode
    puts "Following are the mode you can choose"
    puts "1. Computer as a codemaker and Player as a codebreaker"
    puts "2. Player as a codemaker and Player as a codebreaker\n"
    choice = -1
    until choice.between?(1, 2)
      print "Choose a mode (1-2): "
      choice = gets.to_i
      puts "\n"
    end
    choice
  end

  def play_choosen_mode(choice)
    case choice
    when 1
      play_computer_vs_player
    when 2
      play_player_vs_player
    end
  end

  def play_computer_vs_player
    puts "You have choosen the 'Computer vs Player' mode!\n".colorize(color: :blue, mode: :bold)
    codemaker = ComputerPlayer.new
    codemaker.generate_code
    codebreaker = CodeBreakerHuman.new
    puts "CodeBreaker! Break code\n"
    total_trials = 7
    loop do
      if total_trials.zero?
        puts "You lost the game".colorize(:red)
        break
      end
      total_trials -= 1
      guess = codebreaker.get_choices
      white_pegs, black_pegs = codemaker.provide_feedback(guess)
      if black_pegs == 4
        puts "You won the game".colorize(:red)
        break
      else
        puts "#{black_pegs} colors are correct in both color and position".colorize(:blue)
        puts "#{white_pegs} colors are correct in color but not in position\n\n".colorize(:blue)
      end
    end
  end

  def play_player_vs_player
    puts "You have choosen the 'Player vs Player' mode!\n".colorize(color: :blue, mode: :bold)
    codemaker = CodeMakerHuman.new
    puts "CodeMaker! Make code\n"
    codemaker.generate_code
    puts "CodeBreaker! Break code\n"
    codebreaker = CodeBreakerHuman.new
    total_trials = 2
    loop do
      if total_trials.zero?
        puts "CodeBreaker lost the game".colorize(:red)
        puts "CodeMaker won the game".colorize(:red)
        break
      end
      total_trials -= 1
      guess = codebreaker.get_choices
      white_pegs, black_pegs = codemaker.provide_feedback(guess)
      if black_pegs == 4
        puts "CodeBreaker won the game".colorize(:red)
        puts "CodeMaker lost the game".colorize(:red)
        break
      else
        puts "#{black_pegs} colors are correct in both color and position".colorize(:blue)
        puts "#{white_pegs} colors are correct in color but not in position\n\n".colorize(:blue)
      end
    end
  end
end
