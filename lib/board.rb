require './lib/cell'

class Board

  def initialize
  end

  def columns
    (1..4).to_a
  end

  def rows
    ("A".."D").to_a
  end
end
