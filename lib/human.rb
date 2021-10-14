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
  def select_piece(chess_pieces, pieces_lost)
    @pieces_lost = pieces_lost
    @chess_pieces = chess_pieces
    ask_for_move
    piece_coordinates = piece_position until valid_piece_move?(piece_coordinates)
    piece_coordinates
  end

  # player puts in coordinates that correspond with a position in the arr
  def piece_position
    coord = gets.chomp.chars
    x = coord[0].to_i
    y = convert_letter_to_num(coord[1])
    p [y, x]
    [y, x]
  end

  def check_piece_options(move_arr)
    if move_arr.nil?
      cannot_move
      return false
    end

    opposing_team = toggle_team
    move_arr.each do |option|
      return true if valid_piece_move?(option, opposing_team)
    end
    cannot_move
    false
  end

  def new_piece_position(old_coord, move_arr)
    new_position
    opposing_team = toggle_team
    new_coord = piece_position until valid_piece_move?(new_coord, opposing_team)

    if move_arr.include?(new_coord)
      update_position(new_coord, old_coord)
    else
      # should only get into this if the player is human
      invalid_move
      select_different_piece? ? move_piece : new_piece_position(old_coord, move_arr)
    end
  end

  def select_different_piece?
    answer = pick_another_piece
    return true if answer == 'y'

    false
  end

  def valid_piece_move?(coordinates, team = @colour)
    return false if coordinates.nil?

    @chess_pieces.each_pair do |_key, value|
      return true if value['color'] == team && value['square'] == [coordinates]

      return false if value['color'] != team && value['square'] == [coordinates]
    end
    true
  end

  def convert_letter_to_num(letter)
    index = 0
    ('a'..'h').to_a.each do |char|
      return index if char == letter

      index += 1
    end
    invalid_move
  end

  def update_position(new_coord, piece_coord)
    piece_key = []
    board_pieces = @chess_pieces

    board_pieces.each_pair do |_key, value|
      value.each_value do |position|
        next unless position == [piece_coord]

        piece_key.push(value['code'])
        position.replace([new_coord])
      end
    end
    remove_piece(new_coord, piece_key, board_pieces)
  end

  # removes a piece from the hash if it has been overtaken
  def remove_piece(coord, piece, board_pieces)
    board_pieces.each_pair do |key, value|
      value.each_value do |data|
        next unless data == [coord]

        next if [value['code']] == piece

        @pieces_lost.push(value['code'])
        board_pieces.delete(key)
      end
    end
    board_pieces
  end

  def toggle_team
    case @colour
    when 'Blue'
      'Yellow'
    when 'Yellow'
      'Blue'
    end
  end
end

# ask_for_move
#  each get their own set of chess pieces depending on the colour
