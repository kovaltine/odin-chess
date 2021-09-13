# frozen_string_literal:true

require_relative './board'
require_relative './chess_piece'

# plays the chess game
class Chess
  include Board
  include ChessPiece

  def initialize
    # @black_positions = black_positions
    # @white_positions = white_positions
    @chess_pieces = start_chess_pieces
    @pieces_lost = []
    # how to make sure you can only select your own color?
    # filter piece locations to those only starting with "black" or "white"
    @player = 'black' # choose_team
    # @player_positions = @white_positions
    play_game
  end

  def choose_team
    puts 'Would you like to play as black or white?'
    input = gets.chomp
    case input
    when 'white'
      @player = 0
    when 'black'
      @player = 1
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
      @player = toggle_team
      # puts system('clear')
      puts "Total pieces lost: #{@pieces_lost.flatten}"
      chess_board(@chess_pieces)
      @chess_pieces = move_piece

    end
    puts "Congratulations #{@player}, you won!"
  end

  def move_piece
    puts "#{@player}'s move"
    puts 'enter the coordinates of the piece you would like to move'
    piece_coordinates = get_piece_position until valid_piece_position?(piece_coordinates, @chess_pieces)
    puts 'enter the new coordinates'
    new_coordinates = get_piece_position

    update_position(new_coordinates, piece_coordinates, @chess_pieces)
  end

  def toggle_team
    case @player
    when 'black'
      @player = 'white'
    when 'white'
      @player = 'black'
    end
    @player
  end

  # player puts in coordinates that correspond with a position in the arr
  def get_piece_position
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

  def valid_piece_position?(coordinates, position_arr)
    return false if coordinates.nil?

    position_arr.each_pair do |_key, value|
      value.each_value do |position|
        return true if position == [coordinates]
      end
    end

    false
  end

  # return a special message if it takes a King
  # check for check/checkmate.
  # how to make sure the king can't move somewhere it would be taken?
  def update_position(new_coord, piece_coord, chess_pieces)
    piece_key = []
    board_pieces = chess_pieces

    board_pieces.each_pair do |_key, value|
      value.each_value do |position|
        next unless position == [piece_coord]

        piece_key.push(value['code'])
        position.replace([new_coord])
      end
    end
    remove_piece(new_coord, piece_key, board_pieces)
  end

  # that removes a piece from the hash if it has been overtaken
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
