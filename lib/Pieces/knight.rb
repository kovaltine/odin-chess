# frozen_string_literal:true

# determines the behaviour of knight pieces
class Knight
  def initialize(surrounding, square)
    @start = square
    @surrounding = surrounding
  end

  ## Knight ##
  def knight_pattern
    # at most 8 possibilities
    knight_coords = []
    patterns = [[-2, 1], [-2, -1], [-1, 2], [-1, -2], [2, -1], [2, 1], [1, -2], [1, 2]]
    patterns.each do |pattern|
      knight_coords.push([pattern[0] + @start[0], pattern[1] + @start[1]])
    end
    valid_knight_position(knight_coords)
  end

  # make sure the knight positions are on the board
  def valid_knight_position(coords)
    valid_knight = []
    coords.each do |coord|
      valid_knight.push(coord) if coord[0].between?(0, 7) && coord[1].between?(0, 7)
    end
    valid_knight
  end
end
