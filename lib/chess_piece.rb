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
    'color' => 'black'
  },
  'black_pawn_two' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 1]],
    'color' => 'black'
  },
  'black_pawn_three' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 2]],
    'color' => 'black'
  },
  'black_pawn_four' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 3]],
    'color' => 'black'
  },
  'black_pawn_five' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 4]],
    'color' => 'black'
  },
  'black_pawn_six' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 5]],
    'color' => 'black'
  },
  'black_pawn_seven' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 6]],
    'color' => 'black'
  },
  'black_pawn_eight' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 7]],
    'color' => 'black'
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
    'color' => 'white'
  },
  'white_pawn_two' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 1]],
    'color' => 'white'
  },
  'white_pawn_three' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 2]],
    'color' => 'white'
  },
  'white_pawn_four' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 3]],
    'color' => 'white'
  },
  'white_pawn_five' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 4]],
    'color' => 'white'
  },
  'white_pawn_six' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 5]],
    'color' => 'white'
  },
  'white_pawn_seven' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 6]],
    'color' => 'white'
  },
  'white_pawn_eight' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 7]],
    'color' => 'white'
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
    piece_hash = find_piece_hash(coord)
    # find the type of piece
    piece_type = find_piece_type(piece_hash)
    p piece_type # ex: "rook"

    # determine the pattern that it must follow
    piece_move_arr(piece_type, coord)

    # send it back to move_piece
  end

  def piece_move_arr(type, square)
    case type
    when 'rook'
      rook_pattern(square)
    when 'pawn'
      pawn_pattern(square)
      # one for each piece type
      # when 'knight'
      #   knight_pattern
    # when 'bishop'
    #   bishop_pattern
    end
  end

  def pawn_pattern(start)
    
  end

  def rook_pattern(start)
    @start = start
    move_positive_y = move_positive_y_direction
    move_negative_y = move_negative_y_direction
    move_positive_x = move_positive_x_direction
    move_negative_x = move_negative_x_direction
    [move_positive_y, move_negative_y, move_positive_x, move_negative_x].flatten(1)
  end

  # this is where i should start next
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

  def find_piece_type(piece_hash)
    case piece_hash['color']
    when 'white'
      WHITE_PIECES.each_pair do |key, value|
        return key if value == piece_hash['code']
      end
    when 'black'
      BLACK_PIECES.each_pair do |key, value|
        return key if value == piece_hash['code']
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
