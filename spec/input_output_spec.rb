require "spec_helper"

module ConsoleTTT
  describe InputOutput do
    let(:io) {InputOutput.new}

    it "can get input" do
      allow(io).to receive(:gets) {"some string"}
      expect(io.input).to eq("some string")
    end

    it "outputs to the screen" do
      allow($stdout).to receive(:puts).with("some string")
      io.output("some string")
    end
  end
end