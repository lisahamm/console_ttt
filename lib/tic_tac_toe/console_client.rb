module ConsoleTTT
  class ConsoleClient
    attr_accessor :io, :game, :view, :game_configuration

    def initialize(io, game, game_configuration)
      @io = io
      @game = game
      @game_configuration = game_configuration
      @view = BoardView.new(game.board, io)
    end

    def play!
      while game.in_progress?
        if game.current_player_mark == game_configuration.computer_opponent_mark
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
  end
end