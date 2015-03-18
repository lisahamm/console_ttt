require "spec_helper"

module ConsoleTTT
  describe GameRunner do
    let(:io) {double(InputOutput.new)}
    let(:game) {double(TicTacToe::Game.new)}
    let(:game_configuration) {double(GameConfiguration.new)}
    let(:game_runner) {GameRunner.new(io, game, view, game_configuration)}

    context "#play!" do
      it "runs the game" do
        expect(game_runner.play!)
      end
    end
  end
end