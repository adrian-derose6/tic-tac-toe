
module TicTacToe
  class Board
    attr_accessor :spaces

    def initialize
      @spaces = Array.new(9, "-")
    end

    public

    def generate_board
      board = ""
      (0..8).step(3) do |i|
        board += "| #{@spaces[i]} | #{@spaces[i + 1]} | #{@spaces[i + 2]} |\n"
      end
      puts board + "\n\n\n"
    end

    def add_symbol(position, symbol)
      @spaces[position] = symbol
    end

    def space_taken?(position)
      return @spaces[position] == "X" || @spaces[position] == "O"
    end
  end
end
