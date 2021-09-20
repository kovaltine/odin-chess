# frozen_string_literal:true

require_relative './board'
require_relative './chess_piece'

# plays the chess game
class Chess
  include Board
  include ChessPiece

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
    # until team_lost?
    @team = toggle_team(@team)
    puts_pieces_lost
    chess_board(@chess_pieces)
    @chess_pieces = move_piece

    # end
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

    # movement pattern should contain an array of possible moves
    move_arr = movement_pattern(piece_coordinates)

    # trim the array to only include valid moves
    remove_invalid_moves(move_arr, piece_coordinates)
    # player can only select the moves that are valid
    # p "array of possible moves:#{arr}"

    # update_position(new_coordinates, piece_coordinates, @chess_pieces)
  end

  def remove_invalid_moves(options_arr, coord)
    board_pieces = make_board_piece_arr
    # p "board_pieces #{board_pieces}"
    # trim down the arr until its pieces surrounding the original piece
    trimmed_arr = trim_options(board_pieces, options_arr, coord)

    # contain only those positions that are in the move_arr

    # how do i make it stop if there's a piece in the way
  end

  # trim down the arr until its pieces surrounding the original piece
  def trim_options(board_pieces, options_arr, coord)
    # find the pieces that are immediately surrounding the selected piece
    # surrounding_board_pieces = surrounding_pieces(board_pieces, coord)
    # puts "surrounding_board_pieces #{surrounding_board_pieces}"
    positive_horizontal_options = positive_horizontal_surrounding_pieces(board_pieces, options_arr, coord)
    p positive_horizontal_options

    negative_horizontal_options = negative_horizontal_surrounding_pieces(board_pieces, options_arr, coord)

    p negative_horizontal_options
    # this won't work because it doesn't include options in more than one direction
    # options_arr.each do |option|
    #   trimmed_arr.push(option)
    #   return trimmed_arr if surrounding_board_pieces.includes?(option)
    # end
    # only include coords up to but including that piece
    # if the options_arr contains a surrounding board_piece, keep it as an option
    # make a new array based on the options arr
    # if there's a piece on board that is around it, remove all the options that come afterward
  end

  def surrounding_pieces(board_pieces, coord)
    surrounding = []
    x_direction = surrounding_pieces_horizontal(coord, board_pieces).compact!

    # somehow remove options that follow past the first horizontal piece

    # y-direction
    # num = 0
    # y_direction = surrounding_pieces_horizontal(coord[0], board_pieces, num).compact!
    # surrounding

    # there's two different kinds of diagonal
    # z-direction
    # the board renders in the opposite way you would think
    # a rook can't move diagonally
    # z_direction = surrounding_pieces_diagonal(coord, board_pieces).compact!
    # should get nil from this
    # p z_direction
    surrounding.push([x_direction], [y_direction])
    # surrounding.push()
    # p surrounding

    # should get [6, 0] and [7,1]
    surrounding
  end

  def surrounding_pieces_diagonal(coord, board_pieces)
    positive_y_negative_x = diagonal_pattern([1, -1], coord, board_pieces)
    positive_y_positive_x = diagonal_pattern([1, 1], coord, board_pieces)
    negative_y_positive_x = diagonal_pattern([-1, 1], coord, board_pieces)
    negative_y_negative_x = diagonal_pattern([-1, -1], coord, board_pieces)

    # put all these arrs into one
    p [positive_y_negative_x, positive_y_positive_x, negative_y_negative_x, negative_y_positive_x].flatten(1)
    [positive_y_negative_x, positive_y_positive_x, negative_y_negative_x, negative_y_positive_x].flatten(1)
    # [positive_direction[0], negative_direction[0]].flatten
  end

  # four different functions for each diagonal direction
  # just one, and hard code the positive or negative change
  def diagonal_pattern(pattern, start, board_pieces)
    # following the pattern, if the calculated coord matches a board_piece then return the arr including a board_piece coord
    # make sure the arr is within range of the board
    pieces_diagonal = []
    new_coord = start
    while new_coord[0].between?(0, 7) && new_coord[1].between?(0, 7)
      new_coord[0] += pattern[0]
      new_coord[1] += pattern[1]
      pieces_diagonal.push(new_coord)
      return pieces_diagonal if board_pieces.include?(new_coord)
    end
  end

  def surrounding_pieces_horizontal(coord, board_pieces)
    positive_direction = negative_horizontal_surrounding_pieces(coord, board_pieces)
    negative_direction = positive_horizontal_surrounding_pieces(coord, board_pieces)

    # take the current coord and move horizontally
    # two different functions for positive and negative

    # board_pieces.each do |piece|
    #   if piece[num] >= coord
    #     positive_direction.push(piece)
    #   elsif piece[num] <= coord
    #     negative_direction.push(piece)
    #   end
    # end
    [positive_direction[0], negative_direction[0]].flatten
  end

  # fix index
  def negative_horizontal_surrounding_pieces(board_pieces, options, coord)
    same_y_num = []
    options.each do |option|
      same_y_num.push(option) if option[0] == coord[0]
    end

    on_the_board = []
    same_y_num.each do |nums|
      on_the_board.push(nums) if board_pieces.include?(nums)
    end

    nearest_piece = []
    index = -1
    while index >= -7
      on_the_board.each do |near|
        nearest_piece.push(near) if near == [coord[0], coord[1] + index]
      end
      index -= 1
    end
    p nearest_piece
    nearest_piece.flatten
  end

  def positive_horizontal_surrounding_pieces(board_pieces, options, coord)
    same_y_num = []
    options.each do |option|
      same_y_num.push(option) if option[0] == coord[0]
    end

    on_the_board = []
    same_y_num.each do |nums|
      on_the_board.push(nums) if board_pieces.include?(nums)
    end

    nearest_piece = []
    while nearest_piece.empty?
      index = 1
      on_the_board.each do |near|
        nearest_piece.push(near) if near == [coord[0], coord[1] + index]
      end
      index += 1
    end
    nearest_piece.flatten
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

  def new_piece_position
    puts 'enter the new coordinates'
    opposing_team = toggle_team(@team)
    coord = piece_position until valid_piece_move?(coord, opposing_team)
    # make sure the new square follows the pattern
    # coord == movement_pattern(coord) ? coord : new_piece_position
  end

  # if moving to new can't move to the same place that has the same color
  # if selecting a piece must be one that's on your team
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
