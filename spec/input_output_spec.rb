require "spec_helper"

describe InputOutput do

  it "can get input" do
    io = InputOutput.new
    allow(io).to receive(:gets) {"some string"}
    expect(io.input).to eq("some string")
  end
end