module ConsoleTTT
  class ConsoleClient
    attr_accessor :io, :game, :view, :setup_options

    def initialize(io)
      @io = io
      @setup_options = get_setup_options
      @game = setup_game(setup_options)
      @view = BoardView.new(game.board, io)
    end

    def setup_game(setup_options)
      TicTacToe::Game.new(setup_options[:player1_mark], setup_options[:player2_mark], setup_options[:player1_mark])
    end

    def get_setup_options
      setup_options = {}

      io.output("Please choose your mark (X or O). Enter 1 for X or 2 for O:")
      mark = get_player_mark(io)

      io.output("Do you want to go first or second? Enter 1 or 2:")
      position = get_player_order(io)

      io.output("Do you want to play against the computer? Enter 1 for yes or 2 for no:")
      computer_opponent_mark = get_computer_opponent_mark(io, mark)

      player1_mark, player2_mark = mark, get_opponent(mark) if position == 1
      player1_mark, player2_mark = get_opponent(mark), mark if position == 2

      setup_options[:player1_mark] = player1_mark
      setup_options[:player2_mark] = player2_mark
      setup_options[:computer_opponent_mark] = computer_opponent_mark

      setup_options
    end

    def play!
      while game.in_progress?
        if game.current_player_mark == setup_options[:computer_opponent_mark]
          game.take_turn(game.generate_ai_move)
        else
          move = get_move(io)
          game.take_turn(move)
        end
        display_board
      end
    end

    private

    def get_move(io)
      io.output("Player #{game.current_player_mark}, it's your turn. What cell would you like to mark (1-9)?")
      get_user_input(io).chomp.to_i - 1
    end

    def get_user_input(io)
      io.input
    end

    def display_board
      view.display
    end

    def get_player_mark(io)
      answer = get_user_input(io).chomp.to_i
      answer == 1 ? "X" : "O"
    end

    def get_player_order(io)
      get_user_input(io).chomp.to_i
    end

    def computer_opponent?(io)
      answer = get_user_input(io).chomp.to_i
    end

    def get_computer_opponent_mark(input_number, mark)
      answer = get_user_input(io).chomp.to_i
      return nil if answer == 2
      return get_opponent(mark)
    end

    def get_opponent(mark)
      mark == "X" ? "O" : "X"
    end
  end
end