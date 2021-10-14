# frozen_string_literal:true

require_relative './board'
require_relative './chess_pieces'
require_relative './surrounding_piece'
require_relative './display'
require_relative './human'
require_relative './computer'

# plays the chess game
class Chess
  # include Board
  include ChessPieces
  include SurroundingPiece
  include Display

  def initialize
    @chess_pieces = start_chess_pieces
    @pieces_lost = []
    choose_team
    determine_computer
    determine_human
    @team = 'Blue'
    play_game
  end

  def determine_computer
    @computer = Computer.new
    @computer.colour = @comp_team
  end

  def determine_human
    @human = Human.new
    @human.colour = @player_team
  end

  def choose_team
    input = pick_team
    case input
    when 'Yellow'
      @comp_team = 'Blue'
      @player_team = 'Yellow'
    when 'Blue'
      @player_team = 'Blue'
      @comp_team = 'Yellow'
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
      puts_pieces_lost
      board.chess_board(@chess_pieces)
      selection = player_turn
      p "selection #{selection}"
      # the selection is what @chess_pieces is getting set equal to
      temp = move_piece(selection)
      until temp.is_a?(Hash)
        selection = player_turn
        p "selection #{selection}"
        temp = move_piece(selection)
      end
      @chess_pieces = temp
      # don't make the transformation to @chess_pieces unless it returns what we want

      @team = toggle_team
    end
    end_message
  end

  def player_turn
    if @team == @player_team
      @human.select_piece(@chess_pieces, @pieces_lost)
    elsif @team == @comp_team
      @computer.select_piece(@chess_pieces, @pieces_lost)
    end
  end

  def move_piece(selection)
    surrounding_pieces = surrounding_board_pieces(selection)
    move_arr = movement_pattern(selection, surrounding_pieces)
    if @team == @player_team
      @human.check_piece_options(move_arr) ? @human.new_piece_position(selection, move_arr) : player_turn
    elsif @team == @comp_team
      @computer.check_piece_options(move_arr) ? @computer.update_position : false
    end
  end

  def toggle_team
    case @team
    when 'Blue'
      'Yellow'
    when 'Yellow'
      'Blue'
    end
  end

  # the exit condition will be if one of the players has lost their king
  def team_lost?
    p @chess_pieces.key?('yellow_king')
    p @chess_pieces.key?('blue_king')
    return false if @chess_pieces.key?('yellow_king') && @chess_pieces.key?('blue_king')

    true
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
end

#   def check_piece_options(move_arr)
#     if move_arr.nil?
#       cannot_move
#       return false
#     end

#     opposing_team = toggle_team(@team)
#     move_arr.each do |option|
#       return true if valid_piece_move?(option, opposing_team)
#     end
#     cannot_move
#     false
#   end

#   def new_piece_position(old_coord, move_arr)
#     new_position
#     opposing_team = toggle_team(@team)
#     new_coord = piece_position until valid_piece_move?(new_coord, opposing_team)
#     if move_arr.include?(new_coord)
#       update_position(new_coord, old_coord)
#     else
#       # should only get into this if the player is human
#       invalid_move
#       select_different_piece? ? move_piece : new_piece_position(old_coord, move_arr)
#     end
#   end

#   def select_different_piece?
#     answer = pick_another_piece
#     return true if answer == 'y'

#     false
#   end

#   def valid_piece_move?(coordinates, team = @team)
#     return false if coordinates.nil?

#     @chess_pieces.each_pair do |_key, value|
#       return true if value['color'] == team && value['square'] == [coordinates]

#       return false if value['color'] != team && value['square'] == [coordinates]
#     end
#     true
#   end

#   def convert_letter_to_num(letter)
#     index = 0
#     ('a'..'h').to_a.each do |char|
#       return index if char == letter

#       index += 1
#     end
#     invalid_move
#   end

#   def update_position(new_coord, piece_coord)
#     piece_key = []
#     board_pieces = @chess_pieces

#     board_pieces.each_pair do |_key, value|
#       value.each_value do |position|
#         next unless position == [piece_coord]

#         piece_key.push(value['code'])
#         position.replace([new_coord])
#       end
#     end
#     remove_piece(new_coord, piece_key, board_pieces)
#   end

#   # removes a piece from the hash if it has been overtaken
#   def remove_piece(coord, piece, board_pieces)
#     board_pieces.each_pair do |key, value|
#       value.each_value do |data|
#         next unless data == [coord]

#         next if [value['code']] == piece

#         @pieces_lost.push(value['code'])
#         board_pieces.delete(key)
#       end
#     end
#     board_pieces
#   end
# end

# class Human < Chess
#   include ChessPieces
#   include SurroundingPiece
#   include Display

#   attr_accessor :colour

#   # this is how to move a piece for human
#   def move_piece
#     ask_for_move
#     piece_coordinates = piece_position until valid_piece_move?(piece_coordinates)
#     surrounding_pieces = surrounding_board_pieces(piece_coordinates)
#     move_arr = movement_pattern(piece_coordinates, surrounding_pieces)
#     # p "move_arr #{move_arr}"
#     check_piece_options(move_arr) ? new_piece_position(piece_coordinates, move_arr) : move_piece
#   end

#   # player puts in coordinates that correspond with a position in the arr
#   def piece_position
#     coord = gets.chomp.chars
#     x = coord[0].to_i
#     y = convert_letter_to_num(coord[1])
#     [y, x]
#   end
# end

# class Computer < Chess
#   include ChessPieces
#   include SurroundingPiece
#   include Display

#   attr_accessor :colour

#   def move_piece
#     ask_for_move_computer
#     piece_coordinates = comp_piece_position
#     surrounding_pieces = surrounding_board_pieces(piece_coordinates)
#     move_arr = movement_pattern(piece_coordinates, surrounding_pieces)
#     # randomly select an option from move_arr
#     # p "move_arr #{move_arr}"
#     check_piece_options(move_arr) ? new_piece_position(piece_coordinates, move_arr) : move_piece
#   end

#   def comp_piece_position
#     # go through all the pieces that match the comp colour
#     pieces = find_comp_pieces
#     p "pieces #{pieces}"
#     # randomly select one
#     select_piece(pieces)
#   end

#   def find_comp_pieces
#     comp_pieces = []
#     @chess_pieces.each_pair do |_key, value|
#       value.each_pair do |property, data|
#         next unless property == @colour

#         board_pieces.push(data)
#       end
#     end
#     comp_pieces.flatten(1)
#   end

#   def select_piece(pieces)
#     # selects a pieces
#     piece = pieces[rand(pieces.length)]
#     # now i need the coord
#     p "piece #{piece}"
#   end
# end
