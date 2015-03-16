module ConsoleTTT
  class GameConfiguration

    attr_reader :player1_mark, :player2_mark, :computer_opponent_mark

    class ConfigValue
      attr_reader :value, :prompt

      def initialize(io, prompt)
        @io, @prompt = io, prompt
      end

      def run!
        @value = ""
        @io.output(prompt)
        input = get_input
        if valid?(input)
          yield value = input.to_i
          true
        else
          false
        end
      end

      private

      def get_input
        input = @io.input.chomp
      end

      def valid?(input)
        input == "1" || input == "2"
      end
    end


    def initialize(io)
      @io = io
    end

    def setup!
      io.output("Please choose your mark (X or O). Enter 1 for X or 2 for O:")
      mark = get_player_mark(io)

      io.output("Do you want to go first or second? Enter 1 or 2:")
      position = get_player_order(io)

      io.output("Do you want to play against the computer? Enter 1 for yes or 2 for no:")
      @computer_opponent_mark = get_computer_opponent_mark(io, mark)

      @player1_mark, @player2_mark = case position
      when 1
        [mark, get_opponent(mark)]
      when 2
        [get_opponent(mark), mark]
      end
    end

    def current_player
      @player1_mark
    end


    private

    attr_reader :io

    def get_player_mark(io)
      answer = io.input.chomp.to_i
      answer == 1 ? "X" : "O"
    end

    def get_player_order(io)
      io.input.chomp.to_i
    end

    def computer_opponent?(io)
      answer = io.input.chomp.to_i
    end

    def get_computer_opponent_mark(input_number, mark)
      answer = io.input.chomp.to_i
      return nil if answer == 2
      return get_opponent(mark)
    end

    def get_opponent(mark)
      mark == "X" ? "O" : "X"
    end
  end
end