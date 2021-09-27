# frozen_string_literal:true

BLACK_PIECES = {
  'rook' => " \u2656",
  'knight' => " \u2658",
  'bishop' => " \u2657",
  'queen' => " \u2655",
  'king' => " \u2654",
  'pawn' => " \u2659"
}.freeze

WHITE_PIECES = {
  'rook' => " \u265c",
  'knight' => " \u265e",
  'bishop' => " \u265d",
  'queen' => " \u265b",
  'king' => " \u265a",
  'pawn' => " \u265F"
}.freeze

# might need a counter for the pawns to track if it's their first move
CHESS_PIECES = {
  'black_queen_rook' => {
    'code' => BLACK_PIECES.fetch('rook'),
    'square' => [[0, 0]],
    'color' => 'black'
  },
  'black_king_rook' => {
    'code' => BLACK_PIECES.fetch('rook'),
    'square' => [[0, 7]],
    'color' => 'black'
  },
  'black_queen_knight' => {
    'code' => BLACK_PIECES.fetch('knight'),
    'square' => [[0, 1]],
    'color' => 'black'
  },
  'black_king_knight' => {
    'code' => BLACK_PIECES.fetch('knight'),
    'square' => [[0, 6]],
    'color' => 'black'
  },
  'black_queen_bishop' => {
    'code' => BLACK_PIECES.fetch('bishop'),
    'square' => [[0, 2]],
    'color' => 'black'
  },
  'black_king_bishop' => {
    'code' => BLACK_PIECES.fetch('bishop'),
    'square' => [[0, 5]],
    'color' => 'black'
  },
  'black_queen' => {
    'code' => BLACK_PIECES.fetch('queen'),
    'square' => [[0, 3]],
    'color' => 'black'
  },
  'black_king' => {
    'code' => BLACK_PIECES.fetch('king'),
    'square' => [[0, 4]],
    'color' => 'black'
  },
  'black_pawn_one' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 0]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_two' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 1]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_three' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 2]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_four' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 3]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_five' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 4]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_six' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 5]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_seven' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 6]],
    'color' => 'black',
    'move' => 0
  },
  'black_pawn_eight' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 7]],
    'color' => 'black',
    'move' => 0
  },

  # whitepieces
  'white_queen_rook' => {
    'code' => WHITE_PIECES.fetch('rook'),
    'square' => [[7, 0]],
    'color' => 'white'
  },
  'white_king_rook' => {
    'code' => WHITE_PIECES.fetch('rook'),
    'square' => [[7, 7]],
    'color' => 'white'
  },
  'white_queen_knight' => {
    'code' => WHITE_PIECES.fetch('knight'),
    'square' => [[7, 1]],
    'color' => 'white'
  },
  'white_king_knight' => {
    'code' => WHITE_PIECES.fetch('knight'),
    'square' => [[7, 6]],
    'color' => 'white'
  },
  'white_queen_bishop' => {
    'code' => WHITE_PIECES.fetch('bishop'),
    'square' => [[7, 2]],
    'color' => 'white'
  },
  'white_king_bishop' => {
    'code' => WHITE_PIECES.fetch('bishop'),
    'square' => [[7, 5]],
    'color' => 'white'
  },
  'white_queen' => {
    'code' => WHITE_PIECES.fetch('queen'),
    'square' => [[7, 3]],
    'color' => 'white'
  },
  'white_king' => {
    'code' => WHITE_PIECES.fetch('king'),
    'square' => [[7, 4]],
    'color' => 'white'
  },
  'white_pawn_one' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 0]],
    'color' => 'white',
    'move' => 0
  },
  'white_pawn_two' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 1]],
    'color' => 'white',
    'move' => 0
  },
  'white_pawn_three' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 2]],
    'color' => 'white',
    'move' => 0
  },
  'white_pawn_four' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 3]],
    'color' => 'white',
    'move' => 0
  },
  'white_pawn_five' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 4]],
    'color' => 'white',
    'move' => 0
  },
  'white_pawn_six' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 5]],
    'color' => 'white',
    'move' => 0
  },
  'white_pawn_seven' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 6]],
    'color' => 'white',
    'move' => 0

  },
  'white_pawn_eight' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 7]],
    'color' => 'white',
    'move' => 0
  }
}

# input the hash key, make decisions based on the piece type
module ChessPiece
  def start_chess_pieces
    CHESS_PIECES
  end

  # when a piece is selected it will match the piece with the movement pattern
  def movement_pattern(coord, surrounding)
    @surrounding = surrounding
    @piece_hash = find_piece_hash(coord)
    # find the type of piece
    piece_type = find_piece_type

    # determine the pattern that it must follow
    piece_move_arr(piece_type, coord)

    # send it back to move_piece
  end

  def piece_move_arr(type, square)
    @start = square
    case type
    when 'rook'
      rook_pattern
    when 'pawn'
      pawn_pattern
      # one for each piece type
      # when 'knight'
      #   knight_pattern
      # when 'bishop'
      #   bishop_pattern
    end
  end

  ## Pattern for the Pawns ##
  def pawn_pattern
    moves = []
    moves.push(move_vertical_two_squares) if @piece_hash.fetch_values('move') == [0]
    moves.push(move_vertical_one_square)
    attack = move_diagonal_one_square
    pawn_moves = limit_axis_options_pawn(moves)
    pawn_moves.push(check_pawn_attack(attack))
    p pawn_moves
    pawn_moves
  end

  def check_pawn_attack(attack)
    options = []
    attack.each do |option|
      options.push(option) if @surrounding.include?(option)
    end
    options
  end

  # cannot move forward if there is a piece right in front
  def limit_axis_options_pawn(moves)
    options = []
    moves.each do |option|
      p "limit_axis_options_pawn #{option}"
      return options if @surrounding.include?(option)

      options.push(option)
    end
  end

  def check_surrounding_for_diagonal(color, square)
    diagonal = []
    case color
    when 'white'
      diagonal.push(find_diagonal_match([-1, -1], square)).flatten(1)
      diagonal.push(find_diagonal_match([-1, +1], square)).flatten(1)
    when 'black'
      diagonal.push(find_diagonal_match([+1, -1], square)).flatten(1)
      diagonal.push(find_diagonal_match([+1, +1], square)).flatten(1)
    end
    p "diagonal: #{diagonal}"
    diagonal
  end

  def find_diagonal_match(pattern, square)
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

  def move_vertical_one_square
    case @piece_hash.fetch('color')
    when 'white'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] - 1, square[1]]
    when 'black'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] + 1, square[1]]
    end
  end

  # black will always be at the top, white always at the bottom
  def move_vertical_two_squares
    case @piece_hash.fetch('color')
    when 'white'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] - 2, square[1]]
    when 'black'
      square = @piece_hash.fetch('square').flatten(1)
      [square[0] + 2, square[1]]
    end
  end

  ## Pattern for the Rooks ##
  def rook_pattern
    move_positive_y = move_positive_y_direction
    move_negative_y = move_negative_y_direction
    move_positive_x = move_positive_x_direction
    move_negative_x = move_negative_x_direction
    [move_positive_y, move_negative_y, move_positive_x, move_negative_x].flatten(1)
  end

  def move_positive_y_direction
    positions = []
    # can't hardcode 0, it has to be on the axis nearest to the piece
    y = @start[0]
    y -= 1
    while y <= 7 && y >= 0
      positions.push([y, @start[1]]) unless [y, @start[1]] == @start
      y -= 1
    end
    limit_axis_options(positions)
  end

  def move_negative_y_direction
    positions = []
    # can't hardcode 0, it has to be on the axis nearest to the piece
    y = @start[0]
    y += 1
    while y <= 7 && y >= 0
      positions.push([y, @start[1]]) unless [y, @start[1]] == @start
      y += 1
    end
    limit_axis_options(positions)
  end

  def move_positive_x_direction
    positions = []
    x = @start[1]
    x += 1
    while x <= 7 && x >= 0
      positions.push([@start[0], x]) unless [@start[0], x] == @start
      x += 1
    end
    limit_axis_options(positions)
  end

  def move_negative_x_direction
    positions = []
    x = @start[1]
    x -= 1
    while x <= 7 && x >= 0
      positions.push([@start[0], x]) unless [@start[0], x] == @start
      x -= 1
    end
    limit_axis_options(positions)
  end

  def limit_axis_options(arr)
    options = []
    arr.each do |option|
      options.push(option)
      return options if @surrounding.include?(option)
    end
  end

  def find_piece_type
    case @piece_hash['color']
    when 'white'
      WHITE_PIECES.each_pair do |key, value|
        return key if value == @piece_hash['code']
      end
    when 'black'
      BLACK_PIECES.each_pair do |key, value|
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
    p 'invalid'
  end
end
