# frozen_string_literal:true

require_relative './board'
require_relative './chess_pieces'
require_relative './surrounding_piece'
require_relative './display'
require_relative './chess'

# computer and human might need to inherit from chess
# computer player
class Computer
  include ChessPieces
  include SurroundingPiece
  include Display

  attr_accessor :colour

  def move_piece(chess_pieces)
    p "colour #{@colour}"
    @chess_pieces = chess_pieces
    ask_for_move_computer
    piece_coordinates = comp_piece_position
    surrounding_pieces = surrounding_board_pieces(piece_coordinates)
    move_arr = movement_pattern(piece_coordinates, surrounding_pieces)
    # randomly select an option from move_arr
    # p "move_arr #{move_arr}"
    check_piece_options(move_arr) ? new_piece_position(piece_coordinates, move_arr) : move_piece
  end

  def comp_piece_position
    # go through all the pieces that match the comp colour
    pieces = find_comp_pieces
    # randomly select one
    select_piece(pieces)
  end

  def find_comp_pieces
    comp_pieces = []
    @chess_pieces.each_pair do |_key, value|
      value.each_pair do |_property, data|
        comp_pieces.push(data) if value['color'] == @colour
      end
    end
    comp_pieces.flatten(1)
  end

  def select_piece(pieces)
    pieces[rand(pieces.length)]
  end
end

# ask_for_move
# saves the colour
# picks a piece and selects a square to move to
