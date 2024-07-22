require_relative("player")

class CodeBreakerHuman < Player
end

class CodeMakerHuman < Player
  def provide_feedback(guess)
    white_pegs = 0
    black_pegs = 0
    @code.each_with_index do |color, index|
      if color == guess[index]
        black_pegs += 1
      elsif guess.include?(color)
        white_pegs += 1
      end
    end

    [white_pegs, black_pegs]
  end

  def generate_code
    @code = get_choices
    nil
  end
end
