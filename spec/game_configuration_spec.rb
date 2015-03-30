require "spec_helper"

module ConsoleTTT
  describe GameConfiguration do
    let(:io) {double(InputOutput.new)}
    let(:game_configuration) {GameConfiguration.new(io)}
    let(:prompts) {["Please choose your mark (X or O). Enter 1 for X or 2 for O:",
                    "Do you want to go first or second? Enter 1 or 2:",
                    "Do you want to play against the computer? Enter 1 for yes or 2 for no:"]
}

    describe "#setup!" do
      context "when user selects X as mark, position as first, and computer as opponent" do
        before(:each) do
          expect(io).to receive(:output).with(prompts[0])
          expect(io).to receive(:output).with(prompts[1])
          expect(io).to receive(:output).with(prompts[2])
          expect(io).to receive(:input).and_return("1", "1", "1")
          game_configuration.setup!
        end

        it "sets player1's mark as X and player2's mark as O" do
          expect(game_configuration.options[:player1_mark]).to eq "X"
          expect(game_configuration.options[:player2_mark]).to eq "O"
        end

        it "sets current player's mark as X" do
          expect(game_configuration.options[:current_player_mark]).to eq "X"
        end

        it "sets computer opponent's mark as O" do
          expect(game_configuration.options[:ai_mark]).to eq "O"
        end
      end

      context "when user selects O as mark, position as first, and no computer opponent" do
        before(:each) do
          expect(io).to receive(:output).with(prompts[0])
          expect(io).to receive(:output).with(prompts[1])
          expect(io).to receive(:output).with(prompts[2])
          expect(io).to receive(:input).and_return("2", "1", "2")
          game_configuration.setup!
        end

        it "sets player1's mark as O and player2's mark as X" do
          expect(game_configuration.options[:player1_mark]).to eq "O"
          expect(game_configuration.options[:player2_mark]).to eq "X"
        end

        it "sets current player's mark as O" do
          expect(game_configuration.options[:current_player_mark]).to eq "O"
        end

        it "sets computer opponent's mark as X" do
          expect(game_configuration.options[:ai_mark]).to be_nil
        end
      end
    end
  end
end