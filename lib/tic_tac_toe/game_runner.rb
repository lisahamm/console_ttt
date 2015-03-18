module ConsoleTTT
  class GameRunner
    attr_accessor :io, :game, :view, :game_configuration

    def initialize(io, game, game_configuration, view)
      @io = io
      @game = game
      @game_configuration = game_configuration
      @view = view
    end

    def play!
      while game.in_progress?
        take_turn
        display_board
      end
      end_game(io)
    end

    private

    def take_turn
      ai_turn? ? ai_move : human_move
    end

    def ai_turn?
      game.current_player_mark == game_configuration.computer_opponent_mark
    end

    def ai_move
      game.take_turn(game.generate_ai_move)
    end

    def human_move
      loop do
        display_message(io, "Player #{game.current_player_mark}" + TAKE_TURN)
        move = get_user_input(io).chomp.to_i - 1
        break if game.take_turn(move)
        display_message(io, INVALID_CELL_INPUT)
      end
    end

    def display_message(io, message)
      io.output(message)
    end

    def get_user_input(io)
      io.input
    end

    def display_board
      view.display
    end

    def end_game(io)
      message = game.winner? ? GAME_OVER_WIN + "Player #{game.get_winning_player}" : GAME_OVER_TIE
      display_message(io, message)
    end

    TAKE_TURN = ", it's your turn. What cell would you like to mark (1-9)?"
    INVALID_CELL_INPUT = "The cell number you entered is invalid. Please try again."
    GAME_OVER_WIN = "Game is over. Winner: "
    GAME_OVER_TIE = "Game is over. Result: tie game."
  end
end