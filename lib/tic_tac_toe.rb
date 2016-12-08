require "./game.rb"
require "./player.rb"
require "./board.rb"

module TicTacToe
  class TicTacToeRunner
    attr_accessor :name1, :name2, :game_data

    def initialize
      @game_data = {
        player1: {name: nil, wins: nil},
        player2: {name: nil, wins: nil},
        draws: nil
      }
      welcome_screen
      game_loop
    end

    def welcome_screen
      puts "|| Welcome to Tic Tac Toe! ||"
      puts "||-------------------------||\n\n\n"
      print "Enter Player 1's name: "
      @name1 = gets.chomp
      puts " "
      print "Enter Player 2's name: "
      @name2 = gets.chomp
      puts " "
    end

    def game_loop
      game_start
      play_again
    end

    def game_start
      board = Board.new
      player1, player2 = Player.new(@name1), Player.new(@name2)
      game = Game.new(player1, player2, board)
    end

    def play_again
      input = nil
      until input == "Y" or input == "N"
        puts "Would you like to play again? (Y/N): "
        input = gets.chomp.upcase
      end
      case input
      when "Y"
        game_start
      when "N"
        puts "Thank you for playing!"
      end
    end
  end
end

TicTacToeRunner.new
