# frozen_string_literal:true

require 'colorize'
require_relative './Pieces/rook'
require_relative './Pieces/knight'
require_relative './Pieces/bishop'

YELLOW_PIECES = {
  'rook' => " \u2656".colorize(:yellow),
  'knight' => " \u2658".colorize(:yellow),
  'bishop' => " \u2657".colorize(:yellow),
  'queen' => " \u2655".colorize(:yellow),
  'king' => " \u2654".colorize(:yellow),
  'pawn' => " \u2659".colorize(:yellow)
}.freeze

BLUE_PIECES = {
  'rook' => " \u265c".colorize(:light_blue),
  'knight' => " \u265e".colorize(:light_blue),
  'bishop' => " \u265d".colorize(:light_blue),
  'queen' => " \u265b".colorize(:light_blue),
  'king' => " \u265a".colorize(:light_blue),
  'pawn' => " \u265F".colorize(:light_blue)
}.freeze

# might need a counter for the pawns to track if it's their first move
# have to change all the names to their colours
CHESS_PIECES = {
  'yellow_queen_rook' => {
    'code' => YELLOW_PIECES.fetch('rook'),
    'square' => [[0, 0]],
    'color' => 'Yellow'
  },
  'yellow_king_rook' => {
    'code' => YELLOW_PIECES.fetch('rook'),
    'square' => [[0, 7]],
    'color' => 'Yellow'
  },
  'yellow_queen_knight' => {
    'code' => YELLOW_PIECES.fetch('knight'),
    'square' => [[0, 1]],
    'color' => 'Yellow'
  },
  'yellow_king_knight' => {
    'code' => YELLOW_PIECES.fetch('knight'),
    'square' => [[0, 6]],
    'color' => 'Yellow'
  },
  'yellow_queen_bishop' => {
    'code' => YELLOW_PIECES.fetch('bishop'),
    'square' => [[0, 2]],
    'color' => 'Yellow'
  },
  'yellow_king_bishop' => {
    'code' => YELLOW_PIECES.fetch('bishop'),
    'square' => [[0, 5]],
    'color' => 'Yellow'
  },
  'yellow_queen' => {
    'code' => YELLOW_PIECES.fetch('queen'),
    'square' => [[0, 3]],
    'color' => 'Yellow'
  },
  'yellow_king' => {
    'code' => YELLOW_PIECES.fetch('king'),
    'square' => [[0, 4]],
    'color' => 'Yellow'
  },
  'yellow_pawn_one' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 0]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_two' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 1]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_three' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 2]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_four' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 3]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_five' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 4]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_six' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 5]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_seven' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 6]],
    'color' => 'Yellow',
    'move' => 0
  },
  'yellow_pawn_eight' => {
    'code' => YELLOW_PIECES.fetch('pawn'),
    'square' => [[1, 7]],
    'color' => 'Yellow',
    'move' => 0
  },

  # whitepieces
  'blue_queen_rook' => {
    'code' => BLUE_PIECES.fetch('rook'),
    'square' => [[7, 0]],
    'color' => 'Blue'
  },
  'blue_king_rook' => {
    'code' => BLUE_PIECES.fetch('rook'),
    'square' => [[7, 7]],
    'color' => 'Blue'
  },
  'blue_queen_knight' => {
    'code' => BLUE_PIECES.fetch('knight'),
    'square' => [[7, 1]],
    'color' => 'Blue'
  },
  'blue_king_knight' => {
    'code' => BLUE_PIECES.fetch('knight'),
    'square' => [[7, 6]],
    'color' => 'Blue'
  },
  'blue_queen_bishop' => {
    'code' => BLUE_PIECES.fetch('bishop'),
    'square' => [[7, 2]],
    'color' => 'Blue'
  },
  'blue_king_bishop' => {
    'code' => BLUE_PIECES.fetch('bishop'),
    'square' => [[7, 5]],
    'color' => 'Blue'
  },
  'blue_queen' => {
    'code' => BLUE_PIECES.fetch('queen'),
    'square' => [[7, 3]],
    'color' => 'Blue'
  },
  'blue_king' => {
    'code' => BLUE_PIECES.fetch('king'),
    'square' => [[7, 4]],
    'color' => 'Blue'
  },
  'blue_pawn_one' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 0]],
    'color' => 'Blue',
    'move' => 0
  },
  'blue_pawn_two' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 1]],
    'color' => 'Blue',
    'move' => 0
  },
  'blue_pawn_three' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 2]],
    'color' => 'Blue',
    'move' => 0
  },
  'blue_pawn_four' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 3]],
    'color' => 'Blue',
    'move' => 0
  },
  'blue_pawn_five' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 4]],
    'color' => 'Blue',
    'move' => 0
  },
  'blue_pawn_six' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 5]],
    'color' => 'Blue',
    'move' => 0
  },
  'blue_pawn_seven' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 6]],
    'color' => 'Blue',
    'move' => 0

  },
  'blue_pawn_eight' => {
    'code' => BLUE_PIECES.fetch('pawn'),
    'square' => [[6, 7]],
    'color' => 'Blue',
    'move' => 0
  }
}

# refactoring ideas: assign each piece type to an object

# input the hash key, make decisions based on the piece type
module ChessPieces
  def start_chess_pieces
    CHESS_PIECES
  end

  # when a piece is selected it will match the piece with the movement pattern
  def movement_pattern(coord, surrounding)
    @surrounding = surrounding
    @piece_hash = find_piece_hash(coord)
    piece_type = find_piece_type
    piece_move_arr(piece_type, coord)
    # bring limit_axis_options to this function
  end

  # get the arr of potential moves
  def piece_move_arr(type, square)
    @start = square.freeze
    # hopefully can get rid of @type
    @type = type
    case type
    when 'rook'
      Rook.new(@surrounding, square).rook_pattern
    when 'pawn'
      # pawn would need four arguments
      # pawn = Pawn.new(@surrounding, square, @piece_hash)
      pawn_pattern
    when 'knight'
      Knight.new(@surrounding, square).knight_pattern
    when 'bishop'
      Bishop.new(@surrounding, square).bishop_pattern
    when 'queen'
      # queen would be adding together the rook and the bishop patterns
      queen_pattern(square)
    when 'king'
      king_pattern(square)
    end
  end

  ## King ##
  # could use the first axis options of the queen
  def king_pattern(square)
    like_a_rook = Rook.new(@surrounding, square).king_pattern
    like_a_bishop = Bishop.new(@surrounding, square), king_pattern

    [like_a_rook, like_a_bishop].compact!
  end

  ## Queen ##
  def queen_pattern(square)
    move_x_y = Rook.new(@surrounding, square).rook_pattern
    move_diagonal = Bishop.new(@surrounding, square).bishop_pattern
    [move_x_y, move_diagonal].flatten(1)
  end

  ## Pawn ##
  # pawn's first move doesn't work properly
  def pawn_pattern
    moves = []
    moves.push(move_vertical_two_squares) # if @piece_hash.fetch_values('move') == [0]
    # p "pawn's move number #{@piece_hash.fetch_values('move')}"
    moves.push(move_vertical_one_square)
    attack = move_diagonal_one_square
    pawn_moves = limit_axis_options_pawn(moves)
    pawn_moves.push(limit_axis_options(attack).flatten(1))
    pawn_moves
  end

  # cannot move forward if there is a piece right in front
  def limit_axis_options_pawn(moves)
    return moves if @surrounding.nil?

    options = []
    moves.each do |option|
      return options if @surrounding.include?(option)

      options.push(option)
    end
  end

  # # add one to pawn moves
  # def add_one
  #   @chess_pieces.each_pair do |_key, value|
  #     value.each_value do |data|
  #       next unless data == [@start]

  #       next unless [value['code']] == @type

  #       value['move'] += 1
  #     end
  #   end
  # end

  def check_pawn_diagonal_moves(arr, color)
    diagonal_moves = []
    @chess_pieces.each do |_key, value|
      value.each_key do |_property|
        next unless value['color'] != color
        next unless arr.include?(value['square'].flatten)

        diagonal_moves.push(value['square'].flatten)
      end
    end
    diagonal_moves
  end

  def check_surrounding_for_diagonal(color, square)
    diagonal = []
    case color
    when 'Blue'
      diagonal.push(find_diagonal_match([-1, -1], square)).flatten(1)
      diagonal.push(find_diagonal_match([-1, +1], square)).flatten(1)
    when 'Yellow'
      diagonal.push(find_diagonal_match([+1, -1], square)).flatten(1)
      diagonal.push(find_diagonal_match([+1, +1], square)).flatten(1)
    end
    diagonal
  end

  def find_diagonal_match(pattern, square)
    return nil if @surrounding.nil?

    @surrounding.each do |option|
      return option if option == [square[0] + pattern[0], square[1] + pattern[1]]
    end
    nil
  end

  def move_diagonal_one_square
    square = @piece_hash.fetch('square').flatten(1)
    color = @piece_hash.fetch('color')
    diagonal = check_surrounding_for_diagonal(color, square)
    check_pawn_diagonal_moves(diagonal, color)
  end

  def move_vertical_one_square
    case @piece_hash.fetch('color')
    when 'Blue'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] - 1, square[1]]
    when 'Yellow'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] + 1, square[1]]
    end
  end

  # Yellow will always be at the top, Blue always at the bottom
  def move_vertical_two_squares
    case @piece_hash.fetch('color')
    when 'Blue'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] - 2, square[1]]
    when 'Yellow'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] + 2, square[1]]
    end
  end

  def limit_axis_options(arr)
    return nil if arr.nil?

    options = []
    arr.each do |option|
      options.push(option)
      return options if @surrounding.include?(option)
    end
  end

  def find_piece_type
    case @piece_hash['color']
    when 'Blue'
      BLUE_PIECES.each_pair do |key, value|
        return key if value == @piece_hash['code']
      end
    when 'Yellow'
      YELLOW_PIECES.each_pair do |key, value|
        return key if value == @piece_hash['code']
      end
    end
  end

  def find_piece_hash(coord)
    @chess_pieces.each do |key, value|
      value.each_key do |_property|
        next unless value['square'].flatten == coord

        return @chess_pieces.fetch(key)
      end
    end
    # taking the new coord and using it as piece selection
    p 'invalid'
  end
end
