require "spec_helper"

module ConsoleTTT
  describe GameConfiguration do
    let(:io) {double(InputOutput.new)}
    let(:game_configuration) {GameConfiguration.new(io)}

    describe "#setup!" do
      context "when user selects X as mark, position as first, and computer as opponent" do
        before(:each) do
          allow(game_configuration).to receive(:collect_game_specifications_from_user).and_return([1,1,1])
          game_configuration.setup!
        end

        it "sets player1's mark as X and player2's mark as O" do
          expect(game_configuration.player1_mark).to eq "X"
          expect(game_configuration.player2_mark).to eq "O"
        end

        it "sets current player's mark as X" do
          expect(game_configuration.current_player_mark).to eq "X"
        end

        it "sets computer opponent's mark as O" do
          expect(game_configuration.computer_opponent_mark).to eq "O"
        end
      end

      context "when user selects O as mark, position as first, and no computer opponent" do
        before(:each) do
          allow(game_configuration).to receive(:collect_game_specifications_from_user).and_return([2,1,2])
          game_configuration.setup!
        end

        it "sets player1's mark as O and player2's mark as X" do
          expect(game_configuration.player1_mark).to eq "O"
          expect(game_configuration.player2_mark).to eq "X"
        end

        it "sets current player's mark as O" do
          expect(game_configuration.current_player_mark).to eq "O"
        end

        it "sets computer opponent's mark as X" do
          expect(game_configuration.computer_opponent_mark).to be_nil
        end
      end
    end
  end
end