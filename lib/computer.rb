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
    @pieces = find_comp_pieces
    @piece_coord = rand_select_piece(@pieces)
  end

  def find_comp_pieces
    comp_pieces = []
    @chess_pieces.each_pair do |_key, value|
      # need to make sure it's only getting the coord
      comp_pieces.push(value['square']) if value['color'] == @colour
    end
    comp_pieces.flatten(1)
  end

  def check_piece_options(move_arr)
    move_arr = remove_invalid_options(move_arr)
    return false if move_arr.empty?

    @new_coord = rand_select_piece(move_arr)
    p "new coord #{@new_coord}"
    @new_coord
    # update_position(option, old_coord)
  end

  # go through the pieces and if there's a piece of the smae colour in the way then the piece can't go that way
  def remove_invalid_options(move_arr)
    removed_options = []
    @chess_pieces.each_pair do |_key, value|
      next unless move_arr.include?(value['square'].flatten) && value['color'] == @colour

      removed_options.push(value['square'].flatten)
    end
    filter_move_arr(move_arr, removed_options)
  end

  def filter_move_arr(move_arr, removed_options)
    filtered = []
    move_arr.each do |option|
      # remove items from removed options from move_arr
      next if option.empty?

      filtered.push(option) unless removed_options.include?(option)
    end
    filtered
  end

  def rand_select_piece(arr)
    arr[rand(arr.length)]
  end

  # dunno if i need this here
  def valid_piece_move?(coordinates, team = @colour)
    return false if coordinates.nil?

    @chess_pieces.each_pair do |_key, value|
      return true if value['color'] == team && value['square'] == [coordinates]
      return false if value['color'] != team && value['square'] == [coordinates]
    end
    true
  end

  def update_position
    piece_key = []
    board_pieces = @chess_pieces

    board_pieces.each_pair do |_key, value|
      value.each_value do |position|
        next unless position == [@piece_coord]

        piece_key.push(value['code'])
        position.replace([@new_coord])
      end
    end
    remove_piece(piece_key, board_pieces)
  end

  # removes a piece from the hash if it has been overtaken
  def remove_piece(piece, board_pieces)
    board_pieces.each_pair do |key, value|
      value.each_value do |data|
        next unless data == [@new_coord]

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
