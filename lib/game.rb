require './lib/computer'
require './lib/user'
require './lib/board'

class Game
  def initialize
    @user_input = ""
  end

  def start
    inf_loop = false
    until inf_loop == true
      start_loop
      @user_input = ""
      @computer = Computer.new
      @user = User.new
      @computer.place_ships
      puts "I have laid out my ships on the grid.\n"
      puts "You now need to lay out your two ships.\n"
      puts "The Cruiser is three units long and the Submarine is two units long.\n"
      puts @user.board.render(true)
      @user.place_ships
      display_boards
      puts " "
      battle_loop
      end_game_display_boards
      winner_announcement
      print "Fancy another round? ¯|_(ツ)_/¯ \n\n"
    end
  end

  def start_loop
    until @user_input == "p" do
      puts "Welcome to BATTLESHIP"
      puts "Enter p to play. Enter q to quit."
      get_user_input
      interpret_user_input
    end
  end

  def end_loop
    until @user_input == "p" do
      puts "Welcome to BATTLESHIP"
      puts "Enter p to play. Enter q to quit."
      get_user_input
      interpret_user_input
    end
  end

  def get_user_input
    @user_input = gets.chomp.downcase
  end

  def interpret_user_input
    if @user_input == "p"
      return ""
    elsif @user_input == "q"
      exit(true)
    else
      puts "Please follow the instructions and try again!"
    end
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @user.board.render(true)
  end

  def battle_loop
    until @computer.ships.all?{|ship| ship.sunk?} || @user.ships.all?{|ship| ship.sunk?}
      display_boards
      puts " "
      @user.fire_shot(@computer)
      @computer.fire_shot(@user)
    end
  end

  def winner_announcement
    if @computer.ships.all?{|ship| ship.sunk?}
      puts "You have defeated me!"
    else
      puts "I have defeated you!"
    end
  end

  def end_game_display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @user.board.render(true)
  end
end

# Computer does not fire on the same spot twice
# User can choose a valid coordinate to fire on
# Entering invalid coordinate prompts user to enter valid coordinate
# Both computer and player shots are reported as a hit, sink, or miss
# User is informed when they have already fired on a coordinate
# Board is updated after a turn
# End Game:
#
# Game ends when all the user’s ships are sunk
# Game ends when all the computer’s ships are sunk
# Game reports who won
# Game returns user back to the Main Menu
