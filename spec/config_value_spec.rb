require "spec_helper"

module ConsoleTTT
  describe ConfigValue do
    describe "#run!" do
      context "when input is valid" do
        it "is true" do

          io = double(InputOutput.new)
          prompt = "Some prompt"
          config_value = ConfigValue.new(io, prompt)

          allow(io).to receive_messages(:output => "Some prompt", :input => "1")
          expect(config_value.run!).to eq true
        end
      end

      context "when input is invalid" do
        it "is false" do

          io = double(InputOutput.new)
          prompt = "Some prompt"
          config_value = ConfigValue.new(io, prompt)

          allow(io).to receive_messages(:output => "Some prompt", :input => "3")
          expect(config_value.run!).to eq false
        end
      end

    end
  end
end