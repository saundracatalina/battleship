require './lib/ship'
require './lib/board'

class User
  attr_reader :ships, :board

  def initialize
    @ships = make_ships
    @board = Board.new
  end

  def make_ships
    ships = []
    ships << Ship.new("Cruiser", 3)
    ships << Ship.new("Submarine", 2)
    ships
  end

  def place_ships
    @ships.each do |ship|
      valid_entry = false
      until valid_entry == true
        puts "Enter the squares for the #{ship.name} (#{ship.length} spaces): "
        user_input = gets.chomp.upcase.split(" ")
          if @board.valid_placement?(ship, user_input)
            valid_entry = true
            @board.place(ship, user_input)
            print @board.render(true)
          else
            puts "Those are invalid coordinates. Please try again: "
          end
      end
    end
  end

  def fire_shot(opponent)
    valid = false
    puts "Enter the coordinate for your shot:"
    until valid == true do
      coord = gets.chomp.upcase
      if valid_coordinate?(coord)
        if opponent.already_shot?(coord)
          puts "Please enter a valid coordinate. You've already shot there."
        else
          valid = true
        end
      end 
    end
  end
end
