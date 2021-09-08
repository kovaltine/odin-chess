# frozen_string_literal : true

require_relative './board'

# plays the chess game
class Chess
  include Board

  def initialize
    # starting positions
    # maybe make this a hash and include the position, char, and patterns that it moves in
    # @black_positions = [
    #   [" \u265c", 0, 0], # black rook
    #   [" \u265e", 0, 1], # knight
    #   [" \u265d", 0, 2], # bishop
    #   [" \u265b", 0, 3], # queen
    #   [" \u265a", 0, 4], # king
    #   [" \u265d", 0, 5], # bishop
    #   [" \u265e", 0, 6], # knight
    #   [" \u265c", 0, 7], # rook
    #   [" \u265F", 1, 0], # pawn
    #   [" \u265F", 1, 1],
    #   [" \u265F", 1, 2],
    #   [" \u265F", 1, 3],
    #   [" \u265F", 1, 4],
    #   [" \u265F", 1, 5],
    #   [" \u265F", 1, 6],
    #   [" \u265F", 1, 7]
    # ]

    # the specific pieces move in the same way, so can save the movement in another area

    @black_positions = {
      'rook' => {
        'piece_code' => " \u265c",
        'position' => [[0, 0], [0, 7]]
      },
      'knight' => {
        'piece_code' => " \u265e",
        'position' => [[0, 1], [0, 6]]
      },
      'bishop' => {
        'piece_code' => " \u265d",
        'position' => [[0, 2], [0, 5]]
      },
      'queen' => {
        'piece_code' => " \u265b",
        'position' => [[0, 3]]
      },
      'king' => {
        'piece_code' => " \u265a",
        'position' => [[0, 4]]
      },
      'pawn' => {
        'piece_code' => " \u265F",
        'position' => [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]
      }
    }

    # @white_positions = [
    #   [" \u2656", 7, 0], # rook
    #   [" \u2658", 7, 1], # knight
    #   [" \u2657", 7, 2], # bishop
    #   [" \u2655", 7, 3], # queen
    #   [" \u2654", 7, 4], # king
    #   [" \u2657", 7, 5], # bishop
    #   [" \u2658", 7, 6], # knight
    #   [" \u2656", 7, 7], # rook
    #   [" \u2659", 6, 0], # pawn
    #   [" \u2659", 6, 1],
    #   [" \u2659", 6, 2],
    #   [" \u2659", 6, 3],
    #   [" \u2659", 6, 4],
    #   [" \u2659", 6, 5],
    #   [" \u2659", 6, 6],
    #   [" \u2659", 6, 7]
    # ]

    @white_positions = {
      'rook' => {
        'piece_code' => " \u2656",
        'position' => [[7, 0], [7, 7]]
      },
      'knight' => {
        'piece_code' => " \u2658",
        'position' => [[7, 1], [7, 6]]
      },
      'bishop' => {
        'piece_code' => " \u2657",
        'position' => [[7, 2], [7, 5]]
      },
      'queen' => {
        'piece_code' => " \u2655",
        'position' => [[7, 3]]
      },
      'king' => {
        'piece_code' => " \u2654",
        'position' => [[7, 4]]
      },
      'pawn' => {
        'piece_code' => " \u2659",
        'position' => [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]]
      }
    }

    # player can choose their team
    @player = 0 # choose_team
    @player_positions = @white_positions
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
  def team_lost?(arr)
    return true if arr.dig('king', 'position').empty?

    false
  end

  # make sure white always goes first
  def play_game
    until team_lost?(@player_positions)
      # puts system('clear')
      chess_board(@black_positions, @white_positions)
      move_piece
      @player = toggle_team
    end
    puts "Congratulations #{@player}, you won!"
  end

  def move_piece
    puts "#{@player} : move"
    puts 'enter the coordinates of the piece you would like to move'
    piece_coordinates = get_piece_position until valid_piece_position?(piece_coordinates, @player_positions)
    puts 'enter the new coordinates'
    new_coordinates = get_piece_position
    @player_positions = update_position(new_coordinates, piece_coordinates, @player_positions)
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

    position_arr.each do |_piece, properties|
      position_arr = properties['position']
      next if position_arr.nil?

      position_arr.each do |position|
        return true if position == coordinates
      end
    end
    false
  end

  # return a special message if it takes a King
  # check for check/checkmate.
  # how to make sure the king can't move somewhere it would be taken?
  def update_position(new_coord, piece_coord, position_arr)
    position_arr.each_value do |properties|
      arr = properties['position']
      arr.map do |piece_position|
        next unless piece_position == piece_coord

        arr.delete piece_position
        arr.push(new_coord)
      end
    end
    position_arr
  end
end
