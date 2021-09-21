# frozen_string_literal:true

# finds all the pieces nearest to the selected chess piece
module SurroundingPiece
  # make an arr of the surrounding pieces
  def surrounding_pieces(board_pieces, coord)
    # find the pieces that are immediately surrounding the selected piece
    surrounding = []
    # why doesn't this flatten?
    surrounding.push(positive_horizontal_surrounding_piece(board_pieces, coord)).flatten
    surrounding.push(negative_horizontal_surrounding_piece(board_pieces, coord))
    surrounding.push(positive_vertical_surrounding_piece(board_pieces, coord))
    surrounding.push(negative_vertical_surrounding_piece(board_pieces, coord))

    diagonal = surrounding_pieces_diagonal(coord, board_pieces).compact!
    surrounding.push(diagonal)
    surrounding.compact!
  end

  # the way the board renders makes everything confusing
  def surrounding_pieces_diagonal(coord, board_pieces)
    diagonal_pieces = []
    diagonal_pieces.push(diagonal_axis_piece([1, -1], coord, board_pieces))
    diagonal_pieces.push(diagonal_axis_piece([1, 1], coord, board_pieces))
    diagonal_pieces.push(diagonal_axis_piece([-1, 1], coord, board_pieces))
    diagonal_pieces.push(diagonal_axis_piece([-1, -1], coord, board_pieces))
    diagonal_pieces.flatten(1)
  end

  def diagonal_axis_piece(pattern, coord, board_pieces)
    new_coord = coord
    new_coord[0] += pattern[0]
    new_coord[1] += pattern[1]
    while new_coord[0].between?(0, 7) && new_coord[1].between?(0, 7)
      # look through the whole array
      board_pieces.each do |piece|
        return piece if [new_coord[0], new_coord[1]] == piece
      end
      new_coord[0] += pattern[0]
      new_coord[1] += pattern[1]
    end
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
        return [near] if near == [coord[0], coord[1] + index]
      end
      index += 1
    end
  end
end
