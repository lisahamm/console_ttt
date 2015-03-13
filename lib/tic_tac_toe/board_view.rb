module ConsoleTTT
  class BoardView
    def initialize(board, io)
      @board = board
      @io = io
    end

    def display
      io.output(cells_to_s)
    end

    private
    attr_accessor :board, :io

    def cells_to_s
      cells = format_empty_cells(board.cells)
      s = "\n+- - - - - -+\n"
      s << "| #{cells[0]} | #{cells[1]} | #{cells[2]} |"
      s << "\n+- - - - - -+\n"
      s << "| #{cells[3]} | #{cells[4]} | #{cells[5]} |"
      s << "\n+- - - - - -+\n"
      s << "| #{cells[6]} | #{cells[7]} | #{cells[8]} |"
      s << "\n+- - - - - -+\n"
    end

    def format_empty_cells(cells)
      cells.map {|cell| cell.symbol == nil ?  ' ' : cell.symbol}
    end
  end
end