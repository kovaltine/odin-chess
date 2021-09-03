# frozen_string_literal : true

require_relative './board'

# plays the chess game
class Chess
  include Board

  def initialize
    # starting positions
    @black_positions = [
      [" \u265c", 0, 0], # black rook
      [" \u265e", 0, 1], # knight
      [" \u265d", 0, 2], # bishop
      [" \u265b", 0, 3], # queen
      [" \u265a", 0, 4], # king
      [" \u265d", 0, 5], # bishop
      [" \u265e", 0, 6], # knight
      [" \u265c", 0, 7], # rook
      [" \u265F", 1, 0], # pawn
      [" \u265F", 1, 1],
      [" \u265F", 1, 2],
      [" \u265F", 1, 3],
      [" \u265F", 1, 4],
      [" \u265F", 1, 5],
      [" \u265F", 1, 6],
      [" \u265F", 1, 7]
    ]

    @white_positions = [
      [" \u2656", 7, 0], # rook
      [" \u2658", 7, 1], # knight
      [" \u2657", 7, 2], # bishop
      [" \u2655", 7, 3], # queen
      [" \u2654", 7, 4], # king
      [" \u2657", 7, 5], # bishop
      [" \u2658", 7, 6], # knight
      [" \u2656", 7, 7], # rook
      [" \u2659", 6, 0], # pawn
      [" \u2659", 6, 1],
      [" \u2659", 6, 2],
      [" \u2659", 6, 3],
      [" \u2659", 6, 4],
      [" \u2659", 6, 5],
      [" \u2659", 6, 6],
      [" \u2659", 6, 7]
    ]
    # player can choose their team
    @player = 0
    @player_positions = @white_positions
    play_game
  end

  # the exit condition will be if one of the players has lost their king
  def team_lost?(arr)
    arr.map do |piece|
      return false if piece[0] == " \u2654" || piece[0] == " \u265a"
    end
    true
  end

  # make sure white always goes first
  def play_game
    until team_lost?(@player_positions)
      puts "#{@player} your turn"
      chess_board(@black_positions, @white_positions)
      puts 'enter the coordinates of the piece you would like to move'
      piece_coordinates = get_piece_position until valid_piece_position?(piece_coordinates, @player_positions)
      puts 'enter the new coordinates'
      new_coordinates = get_piece_position
      @player_positions = update_position(new_coordinates, piece_coordinates, @player_positions)
      @player = toggle_team
    end
  end

  def toggle_team
    @player = toggle_index(@player)
    case @player
    when 0
      @player_positions = @white_positions
    when 1
      @player_positions = @black_positions
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

    position_arr.map do |piece_position|
      return true if piece_position[1] == coordinates[0] && piece_position[2] == coordinates[1]
    end
    false
  end

  def update_position(new_coord, piece_coord, position_arr)
    position_arr.map do |piece_position|
      next unless piece_position[1] == piece_coord[0] && piece_position[2] == piece_coord[1]

      # update piece position
      piece_position[1] = new_coord[0]
      piece_position[2] = new_coord[1]
    end
    position_arr
  end
end
