# frozen_string_literal:true

require_relative './board'
require_relative './chess_piece'
require_relative './surrounding_piece'

# plays the chess game
class Chess
  include Board
  include ChessPiece
  include SurroundingPiece

  def initialize
    @chess_pieces = start_chess_pieces
    @pieces_lost = []
    @team = 'black' # choose_team
    play_game
  end

  # this function needs to get redone for sure
  def choose_team
    puts 'Would you like to play as black or white?'
    input = gets.chomp
    case input
    when 'white'
      @team = 0
    when 'black'
      @team = 1
    else
      puts "please enter 'black' or 'white'"
      choose_team
    end
  end

  # the exit condition will be if one of the players has lost their king
  def team_lost?
    return false if @chess_pieces.key?('black_king') && @chess_pieces.key?('white_king')

    true
  end

  # make sure white always goes first
  def play_game
    until team_lost?
      p 'play chess'
      @team = toggle_team(@team)
      puts_pieces_lost
      chess_board(@chess_pieces)
      @chess_pieces = move_piece
      p @chess_pieces
    end
    puts "Congratulations #{@team}, you won!"
  end

  def puts_pieces_lost
    system 'clear'
    puts "Casualties: #{@pieces_lost.join}\n"
  end

  def move_piece
    puts "#{@team}'s move"
    puts 'enter the coordinates of the piece you would like to move'
    piece_coordinates = piece_position until valid_piece_move?(piece_coordinates)
    surrounding_pieces = surrounding_board_pieces(piece_coordinates)
    p "surrounding pieces #{surrounding_pieces}"

    move_arr = movement_pattern(piece_coordinates, surrounding_pieces)
    check_piece_options(move_arr) ? new_piece_position(piece_coordinates) : move_piece
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
    when 'black'
      'white'
    when 'white'
      'black'
    end
  end

  def check_piece_options(move_arr)
    return false if move_arr.nil?

    opposing_team = toggle_team(@team)
    move_arr.each do |option|
      return true if valid_piece_move?(option, opposing_team)
    end
    p 'cannot move this piece'
    false
  end

  def new_piece_position(old_coord)
    puts 'enter the new coordinates'
    opposing_team = toggle_team(@team)
    new_coord = piece_position until valid_piece_move?(new_coord, opposing_team)

    update_position(new_coord, old_coord)
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
    puts 'number first, then the letter'
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
    'invalid input'
  end

  def update_position(new_coord, piece_coord)
    piece_key = []
    board_pieces = @chess_pieces

    board_pieces.each_pair do |_key, value|
      value.each_value do |position|
        next unless position == [piece_coord]

        piece_key.push(value['code'])
        position.replace([new_coord])
        # update move if it's a pawn
        value['move'] += 1 if value['code'] == BLACK_PIECES.fetch('pawn') || WHITE_PIECES.fetch('pawn')
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
    p board_pieces
    board_pieces
  end
end
