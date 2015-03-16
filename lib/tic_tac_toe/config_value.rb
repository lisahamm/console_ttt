module ConsoleTTT
  class ConfigValue
    attr_reader :prompt

    def initialize(io, prompt)
      @io, @prompt = io, prompt
    end

    def run!
      @io.output(prompt)
      input = get_input
      if valid?(input)
        yield value = input.to_i
        true
      else
        false
      end
    end

    private

    def get_input
      input = @io.input.chomp
    end

    def valid?(input)
      input == "1" || input == "2"
    end
  end
end