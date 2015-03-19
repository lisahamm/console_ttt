require "spec_helper"
require "tic_tac_toe"

module ConsoleTTT
  describe GameRunner do
    let(:io) {double(InputOutput.new)}

    context "#play!" do
      it "runs the game with two human players" do
        game_configuration = double(GameConfiguration.new(io))
        expect(game_configuration).to receive(:computer_opponent_mark).and_return(nil).exactly(5).times
        game = TicTacToe::Game.new("X", "O", "X")
        view = double(BoardView.new(game.board, io))
        expect(view).to receive(:display).exactly(5).times
        game_runner = GameRunner.new(io, game, game_configuration, view)
        expect(io).to receive(:output).with("Player X" + GameRunner::TAKE_TURN).exactly(3).times
        expect(io).to receive(:output).with("Player O" + GameRunner::TAKE_TURN).exactly(3).times
        expect(io).to receive(:output).with(GameRunner::INVALID_CELL_INPUT)
        expect(io).to receive(:output).with(GameRunner::GAME_OVER_WIN + "Player X")
        expect(io).to receive(:input).and_return("1", "1", "2", "4", "5", "7")
        game_runner.play!
        expect(game.in_progress?).to eq false
      end

      it "runs the game with a human player and computer player" do
        game_configuration = double(GameConfiguration.new(io))
        expect(game_configuration).to receive(:computer_opponent_mark).and_return("O").exactly(6).times
        game = TicTacToe::Game.new("X", "O", "X")
        view = double(BoardView.new(game.board, io))
        expect(view).to receive(:display).exactly(6).times
        game_runner = GameRunner.new(io, game, game_configuration, view)
        expect(io).to receive(:output).with("Player X" + GameRunner::TAKE_TURN).exactly(4).times
        expect(io).to receive(:output).with(GameRunner::INVALID_CELL_INPUT)
        expect(io).to receive(:input).and_return("10", "2", "3", "6")
        expect(game).to receive(:generate_ai_move).and_return(0, 3, 6)
        expect(io).to receive(:output).with(GameRunner::GAME_OVER_WIN + "Player O")
        game_runner.play!
        expect(game.in_progress?).to eq false
      end
    end
  end
end