module ConsoleTTT
  class GameConfiguration
    attr_reader :player1_mark, :player2_mark, :current_player_mark, :computer_opponent_mark

    def initialize(io)
      @io = io
    end

    def setup!
      mark, position, computer_opponent = collect_game_specifications_from_user
      mark = mark == 1 ? "X" : "O"
      @player1_mark, @player2_mark, @current_player_mark = setup_player_marks(mark, position)
      @computer_opponent_mark = get_computer_opponent_mark(computer_opponent, mark)
    end

    private
    attr_reader :io

    def setup_player_marks(mark, position)
      case position
      when 1
        [mark, get_opponent(mark), mark]
      when 2
        [get_opponent(mark), mark, get_opponent(mark)]
      end
    end

    def get_computer_opponent_mark(computer_opponent, mark)
      case computer_opponent
      when 1
        get_opponent(mark)
      when 2
        nil
      end
    end

    def get_opponent(mark)
      mark == "X" ? "O" : "X"
    end


    def collect_game_specifications_from_user
      values = []
      prompts.each do |prompt|
        config_value = ConfigValue.new(io, prompt)
        config_value.run! do |value|
          values << value
        end
      end
      values
    end

    def prompts
      ["Please choose your mark (X or O). Enter 1 for X or 2 for O:",
       "Do you want to go first or second? Enter 1 or 2:",
       "Do you want to play against the computer? Enter 1 for yes or 2 for no:"]
    end
  end
end
