module ConsoleTTT
  class ConsoleClient
    attr_accessor :io, :game, :view, :game_configuration

    def initialize(io, game, game_configuration, view)
      @io = io
      @game = game
      @game_configuration = game_configuration
      @view = view
    end

    def play!
      while game.in_progress?
        if game.current_player_mark == game_configuration.computer_opponent_mark
          game.take_turn(game.generate_ai_move)
        else
          loop do
            move = get_move(io)
            turn = game.take_turn(move)
            break if turn == true
            display_error_message(io)
          end
        end
        display_board
      end
      end_game(io)
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

    def display_error_message(io)
      io.output("The cell number you entered is invalid. Please try again.")
    end

    def end_game(io)
      display_tie_message(io) if game.tie?
      display_winner_message(io) if game.winner?
    end

    def display_tie_message(io)
      io.output("Game is over. Result: tie game.")
    end

    def display_winner_message(io)
      io.output("Game is over. Result: Player #{game.get_winning_player} won.")
    end
  end
end