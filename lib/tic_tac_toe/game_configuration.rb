module ConsoleTTT
  class GameConfiguration
    attr_reader :options

    def initialize(io)
      @io = io
    end

    def setup!
      mark, player_order, computer_opponent = collect_game_specifications_from_user
      mark = mark == 1 ? valid_marks[0] : valid_marks[1]
      @options = {}
      @options[:player1_mark], @options[:player2_mark], @options[:current_player_mark] = setup_player_marks(mark, player_order)
      @options[:ai_mark] = get_computer_opponent_mark(computer_opponent, mark)
    end

    private
    attr_reader :io

    def setup_player_marks(mark, player_order)
      case player_order
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
      mark == valid_marks[0] ? valid_marks[1] : valid_marks[0]
    end

    def collect_game_specifications_from_user
      prompts.map do |prompt|
        config_value = ConfigValue.new(io, prompt, valid_values)
        until config_value.run! == true
          @io.output(invalid_input_message)
        end
        config_value.value
      end
    end

    def prompts
      ["Please choose your mark (X or O). Enter 1 for X or 2 for O:",
       "Do you want to go first or second? Enter 1 or 2:",
       "Do you want to play against the computer? Enter 1 for yes or 2 for no:"]
    end

    def invalid_input_message
      "The value you entered is not valid. Please try again."
    end

    def valid_values
      ["1", "2"]
    end

    def valid_marks
      ["X", "O"]
    end
  end
end
