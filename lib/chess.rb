# frozen_string_literal:true

require_relative './board'
require_relative './chess_pieces'
require_relative './surrounding_piece'
require_relative './display'

# plays the chess game
class Chess
  # include Board
  include ChessPieces
  include SurroundingPiece
  include Display

  def initialize
    @chess_pieces = start_chess_pieces
    @pieces_lost = []
    @comp_team = []
    @player_team = []
    choose_team
    # @team = 'Yellow'
    play_game
  end

  def choose_team
    input = pick_team
    case input
    when 'Yellow'
      @comp_team = 'Blue'
      @player_team = 'Yellow'
    when 'Blue'
      @comp_team = 'Yellow'
      @player_team = 'Blue'
    else
      puts "please enter 'Yellow' or 'Blue'"
      choose_team
    end
  end

  # BUG! freezes when you pick the other team
  # make sure Blue always goes first
  def play_game
    board = Board.new
    until team_lost?
      @team = toggle_team(@team)
      puts_pieces_lost
      board.chess_board(@chess_pieces)
      @chess_pieces = move_piece
    end
    end_message
  end

  # def first_round
  #   puts_pieces_lost
  #   chess_board(@chess_pieces)
  #   @chess_pieces = move_piece
  # end

  # the exit condition will be if one of the players has lost their king
  def team_lost?
    return false if @chess_pieces.key?('black_king') && @chess_pieces.key?('white_king')

    true
  end

  def move_piece
    ask_for_move
    piece_coordinates = piece_position until valid_piece_move?(piece_coordinates)
    surrounding_pieces = surrounding_board_pieces(piece_coordinates)
    move_arr = movement_pattern(piece_coordinates, surrounding_pieces)
    # p "move_arr #{move_arr}"
    check_piece_options(move_arr) ? new_piece_position(piece_coordinates, move_arr) : move_piece
  end

  # find the surrounding chess pieces
  def surrounding_board_pieces(coord)
    board_pieces = make_board_piece_arr
    surrounding_pieces(board_pieces, coord)
  end

  def make_board_piece_arr
    board_pieces = []
    @chess_pieces.each_pair do |_key, value|
      value.each_pair do |property, data|
        next unless property == 'square'

        board_pieces.push(data)
      end
    end
    board_pieces.flatten(1)
  end

  def toggle_team(team)
    case team
    when 'Yellow'
      'Blue'
    when 'Blue'
      'Yellow'
    end
  end

  def check_piece_options(move_arr)
    if move_arr.nil?
      cannot_move
      return false
    end

    opposing_team = toggle_team(@team)
    move_arr.each do |option|
      return true if valid_piece_move?(option, opposing_team)
    end
    cannot_move
    false
  end

  def new_piece_position(old_coord, move_arr)
    new_position
    opposing_team = toggle_team(@team)
    new_coord = piece_position until valid_piece_move?(new_coord, opposing_team)
    if move_arr.include?(new_coord)
      update_position(new_coord, old_coord)
    else
      invalid_move
      select_different_piece? ? move_piece : new_piece_position(old_coord, move_arr)
    end
  end

  def select_different_piece?
    answer = pick_another_piece
    return true if answer == 'y'

    false
  end

  def valid_piece_move?(coordinates, team = @team)
    return false if coordinates.nil?

    @chess_pieces.each_pair do |_key, value|
      return true if value['color'] == team && value['square'] == [coordinates]

      return false if value['color'] != team && value['square'] == [coordinates]
    end
    true
  end

  # player puts in coordinates that correspond with a position in the arr
  def piece_position
    coord = gets.chomp.chars
    x = coord[0].to_i
    y = convert_letter_to_num(coord[1])
    [y, x]
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
end
