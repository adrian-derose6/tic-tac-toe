require "./board.rb"
require "./player.rb"

module TicTacToe
  class Game
    attr_accessor :player1, :player2, :turn, :board

    @@winning_positions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    def initialize(player1, player2, board)
      ##initialize external objects utilized by this class.
      @player1 = player1
      @player2 = player2
      @board = board

      ##initialize data for current game run
      @current_turn = 1
      @first_turn = ""
      @winner = ""

      #executes game flow
      play
    end

    def play
      pick_first_turn
      allocate_symbols
      take_turns
    end

    private

    def pick_first_turn
      random = Random.new
      first_turn = random.rand(0..1)
      first_player = nil
      case first_turn
      when 0
        @first_turn = @player1.name
      when 1
        @first_turn = @player2.name
      end
      puts "#{@first_turn} goes first!\n\n\n\n"
    end

    def allocate_symbols
      @player1.sym = "X"
      @player2.sym = "O"
    end

    def take_turns
      until draw? || @winner != ""
        if @first_turn == @player1.name
          (@current_turn.even?) ? turn(@player2) : turn(@player1)
        elsif @first_turn == @player2.name
          (@current_turn.even?) ? turn(@player1) : turn(@player2)
        end
      end
      puts "Game was a draw!" if draw?
    end

    def turn(player)
      puts "Turn #{@current_turn}:"
      puts "---------------------------\n\n\n"
      @board.generate_board
      @board.add_symbol(get_valid_position(player), player.sym)
      announce_win(player)
      @current_turn += 1
    end

    def get_valid_position(player)
      input = 0
      until valid_input?(input)
        print "#{player.name}, enter the cell number that you would like to use (1-9): "
        input = gets.chomp.to_i
        print "Invalid input! " unless valid_input?(input)
        puts "Number is not in range 1-9" unless (input > 0 && input < 10)
        puts "Cell taken." if @board.space_taken?(input - 1)
      end
      input - 1
    end

    def announce_win(player)
      check_winner(player)
      if @winner == player.name
        puts "#{player.name} is the winner!"
      end
    end

    def draw?
      (@current_turn == @board.spaces.length) && (@winner == "")
    end

    def check_winner(player)
      @@winning_positions.each do |triplet|
        @winner = player.name if triplet.all? { |a| @board.spaces[a] == player.sym }
      end
    end

    def valid_input?(input)
      return input > 0 && input < 10 && !@board.space_taken?(input - 1)
    end
  end
end
