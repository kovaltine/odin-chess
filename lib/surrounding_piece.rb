# frozen_string_literal:true

# finds all the pieces nearest to the selected chess piece
module SurroundingPiece
  # make an arr of the surrounding pieces
  def surrounding_pieces(board_pieces, coord)
    surrounding = []
    surrounding.push(positive_horizontal_surrounding_piece(board_pieces, coord))
    surrounding.push(negative_horizontal_surrounding_piece(board_pieces, coord))
    surrounding.push(positive_vertical_surrounding_piece(board_pieces, coord))
    surrounding.push(negative_vertical_surrounding_piece(board_pieces, coord))

    @nearby_pieces = surrounding
    surrounding_pieces_diagonal(coord, board_pieces).compact!.uniq!
  end

  # board renders bottom up, not top down
  def surrounding_pieces_diagonal(coord, board_pieces)
    diagonal_pieces = []
    diagonal_pieces.push(diagonal_axis_piece([1, -1], coord, board_pieces))
    diagonal_pieces.push(diagonal_axis_piece([1, 1], coord, board_pieces))
    diagonal_pieces.push(diagonal_axis_piece([-1, 1], coord, board_pieces))
    diagonal_pieces.push(diagonal_axis_piece([-1, -1], coord, board_pieces))
    diagonal_pieces.flatten(1)
  end

  def diagonal_axis_piece(pattern, coord, board_pieces)
    new_coord = [coord[0], coord[1]]
    new_coord[0] += pattern[0]
    new_coord[1] += pattern[1]
    while new_coord[0].between?(0, 7) && new_coord[1].between?(0, 7)
      board_pieces.each do |piece|
        return @nearby_pieces.push(piece) if !(piece == coord) && ([new_coord[0], new_coord[1]] == piece)
      end
      new_coord[0] += pattern[0]
      new_coord[1] += pattern[1]
    end
    @nearby_pieces
  end

  # x-coordinate is the same, it's the second number
  def negative_vertical_surrounding_piece(board_pieces, coord)
    on_the_axis = []
    board_pieces.each do |piece|
      on_the_axis.push(piece) if piece[1] == coord[1]
    end

    index = 1
    while index <= 7
      on_the_axis.each do |near|
        return near if near == [(coord[0] + index), coord[1]]
      end
      index += 1
    end
  end

  # x-coordinate is the same, it's the second number
  def positive_vertical_surrounding_piece(board_pieces, coord)
    on_the_axis = []
    board_pieces.each do |piece|
      on_the_axis.push(piece) if piece[1] == coord[1]
    end
    # board renders from top down, so if you want to go up the board you have to be negative
    index = -1
    while index >= -7
      on_the_axis.each do |near|
        return near if near == [(coord[0] + index), coord[1]]
      end
      index -= 1
    end
  end

  def negative_horizontal_surrounding_piece(board_pieces, coord)
    on_the_axis = []
    board_pieces.each do |piece|
      on_the_axis.push(piece) if piece[0] == coord[0]
    end

    index = -1
    while index >= -7
      on_the_axis.each do |near|
        return near if near == [coord[0], coord[1] + index]
      end
      index -= 1
    end
  end

  def positive_horizontal_surrounding_piece(board_pieces, coord)
    on_the_axis = []
    board_pieces.each do |piece|
      on_the_axis.push(piece) if piece[0] == coord[0]
    end

    index = 1
    while index <= 7
      on_the_axis.each do |near|
        return near if near == [coord[0], coord[1] + index]
      end
      index += 1
    end
  end
end
