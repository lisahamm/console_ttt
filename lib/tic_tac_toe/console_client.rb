module ConsoleTTT
  class ConsoleClient
    attr_accessor :game, :io, :view

    def initialize(game, io, view)
      @game = game
      @io = io
      @view = view
    end

    def game_runner
      while game.in_progress?
        move = get_move(io)
        game.take_turn(move)
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