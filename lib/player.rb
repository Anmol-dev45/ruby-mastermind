class Player
  def initialize
    @colors = %w[red yellow green cyan blue magenta]
  end

  def display_color_options(colors)
    puts "Available colors:"
    colors.each_with_index do |color, index|
      puts "#{index + 1}. #{color.colorize(color.to_sym)}"
    end
    puts "\n"
  end

  def get_color_choice(index, colors)
    choice = nil
    until (1..colors.size).include?(choice)
      print "Choose a color for index #{index + 1} (1-#{colors.size}): "
      choice = gets.chomp.to_i
      puts "\n"
    end
    colors[choice - 1]
  end

  def get_choices
    chosen_colors = []
    (0..3).each do |index|
      colors = @colors - chosen_colors
      display_color_options colors
      chosen_colors[index] = get_color_choice(index, colors)
    end

    puts "You have chosen the following colors:"
    chosen_colors.each_with_index do |color, index|
      puts "Index #{index + 1}: #{color.colorize(color: color.to_sym, mode: :bold)}"
    end
    puts "\n"

    chosen_colors
  end
end
