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

  def select_piece(chess_pieces, pieces_lost)
    @pieces_lost = pieces_lost
    @chess_pieces = chess_pieces
    ask_for_move_computer
    pieces = find_comp_pieces
    p rand_select_piece(pieces)
  end

  def find_comp_pieces
    comp_pieces = []
    @chess_pieces.each_pair do |_key, value|
      # need to make sure it's only getting the coord
      comp_pieces.push(value['square']) if value['color'] == @colour
    end
    comp_pieces.flatten(1)
  end

  def check_piece_options(move_arr, old_coord)
    return false if move_arr.nil?

    # make it so move_arr does not contain invalid options
    option = rand_select_piece(move_arr)
    # opposing_team = toggle_team
    update_position(option, old_coord)
    # check_piece_options(move_arr, old_coord)
  end

  def rand_select_piece(arr)
    arr[rand(arr.length)]
  end

  def valid_piece_move?(coordinates, team = @colour)
    return false if coordinates.nil?

    @chess_pieces.each_pair do |_key, value|
      return true if value['color'] == team && value['square'] == [coordinates]
      return false if value['color'] != team && value['square'] == [coordinates]
    end
    true
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
