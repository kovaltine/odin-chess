# frozen_string_literal:true

require_relative './board'
require_relative './chess_pieces'
require_relative './surrounding_piece'
require_relative './display'
require_relative './chess'

# human player
class Human
  include ChessPieces
  include SurroundingPiece
  include Display

  attr_accessor :colour

  # this is how to move a piece for human
  def move_piece
    ask_for_move
    piece_coordinates = piece_position until valid_piece_move?(piece_coordinates)
    surrounding_pieces = surrounding_board_pieces(piece_coordinates)
    move_arr = movement_pattern(piece_coordinates, surrounding_pieces)
    # p "move_arr #{move_arr}"
    check_piece_options(move_arr) ? new_piece_position(piece_coordinates, move_arr) : move_piece
  end

  # player puts in coordinates that correspond with a position in the arr
  def piece_position
    coord = gets.chomp.chars
    x = coord[0].to_i
    y = convert_letter_to_num(coord[1])
    [y, x]
  end
end

# ask_for_move
#  each get their own set of chess pieces depending on the colour
