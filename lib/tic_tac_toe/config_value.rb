module ConsoleTTT
  class ConfigValue
    attr_reader :prompt, :value, :valid_values

    def initialize(io, prompt, valid_values)
      @io = io
      @prompt = prompt
      @valid_values = valid_values
    end

    def run!
      @io.output(prompt)
      input = get_input
      if valid?(input, valid_values)
        @value = input.to_i
        true
      else
        false
      end
    end

    private

    def get_input
      input = @io.input.chomp
    end

    def valid?(input, valid_values)
      valid_values.include?(input)
    end
  end
end