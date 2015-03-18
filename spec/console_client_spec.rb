require "spec_helper"

module ConsoleTTT
  describe ConsoleClient do
    let(:io) {double(InputOutput.new)}
    let(:game) {double(TicTacToe::Game.new)}
    let(:game_configuration) {double(GameConfiguration.new)}
    let(:console_client) {ConsoleClient.new(io, game, view, game_configuration)}

    context "#play!" do
      it "runs the game" do
        expect(console_client.play!)
      end
    end
  end
end