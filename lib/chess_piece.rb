# frozen_string_literal:true

# when you select a chess piece, then it runs all the scenarios of where that piece can go
#     it reloads the board and highlights those areas

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

CHESS_PIECES = {
  'black_queen_rook' => {
    'code' => BLACK_PIECES.fetch('rook'),
    'square' => [[0, 0]]
  },
  'black_king_rook' => {
    'code' => BLACK_PIECES.fetch('rook'),
    'square' => [[0, 7]]
  },
  'black_queen_knight' => {
    'code' => BLACK_PIECES.fetch('knight'),
    'square' => [[0, 1]]
  },
  'black_king_knight' => {
    'code' => BLACK_PIECES.fetch('knight'),
    'square' => [[0, 6]]
  },
  'black_queen_bishop' => {
    'code' => BLACK_PIECES.fetch('bishop'),
    'square' => [[0, 2]]
  },
  'black_king_bishop' => {
    'code' => BLACK_PIECES.fetch('bishop'),
    'square' => [[0, 5]]
  },
  'black_queen' => {
    'code' => BLACK_PIECES.fetch('queen'),
    'square' => [[0, 3]]
  },
  'black_king' => {
    'code' => BLACK_PIECES.fetch('king'),
    'square' => [[0, 4]]
  },
  'black_pawn_one' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 0]]
  },
  'black_pawn_two' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 1]]
  },
  'black_pawn_three' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 2]]
  },
  'black_pawn_four' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 3]]
  },
  'black_pawn_five' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 4]]
  },
  'black_pawn_six' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 5]]
  },
  'black_pawn_seven' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 6]]
  },
  'black_pawn_eight' => {
    'code' => BLACK_PIECES.fetch('pawn'),
    'square' => [[1, 7]]
  },

  # #whitepieces
  'white_queen_rook' => {
    'code' => WHITE_PIECES.fetch('rook'),
    'square' => [[7, 0]]
  },
  'white_king_rook' => {
    'code' => WHITE_PIECES.fetch('rook'),
    'square' => [[7, 7]]
  },
  'white_queen_knight' => {
    'code' => WHITE_PIECES.fetch('knight'),
    'square' => [[7, 1]]
  },
  'white_king_knight' => {
    'code' => WHITE_PIECES.fetch('knight'),
    'square' => [[7, 6]]
  },
  'white_queen_bishop' => {
    'code' => WHITE_PIECES.fetch('bishop'),
    'square' => [[7, 2]]
  },
  'white_king_bishop' => {
    'code' => WHITE_PIECES.fetch('bishop'),
    'square' => [[7, 5]]
  },
  'white_queen' => {
    'code' => WHITE_PIECES.fetch('queen'),
    'square' => [[7, 3]]
  },
  'white_king' => {
    'code' => WHITE_PIECES.fetch('king'),
    'square' => [[7, 4]]
  },
  'white_pawn_one' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 0]]
  },
  'white_pawn_two' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 1]]
  },
  'white_pawn_three' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 2]]
  },
  'white_pawn_four' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 3]]
  },
  'white_pawn_five' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 4]]
  },
  'white_pawn_six' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 5]]
  },
  'white_pawn_seven' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 6]]
  },
  'white_pawn_eight' => {
    'code' => WHITE_PIECES.fetch('pawn'),
    'square' => [[6, 7]]
  }
}

# input the hash key, make decisions based on the piece type
module ChessPiece
  def start_chess_pieces
    CHESS_PIECES
  end

  def find_piece_options(piece, position)
    case piece
    when 'rook'
      # call a function to find out where it can go
      movement = [[position[0], 0..7], [0..7, position[1]]]
      piece_movement(movement, position)
    when 'knight'
      movement = [
        [1, 2],
        [-2, -1],
        [-1, 2],
        [2, -1],
        [1, -2],
        [-2, 1],
        [-1, -2],
        [2, 1]
      ]
      piece_movement(movement, position)
    end
  end

  def piece_movement(movement, position)
    # it can't go over top another piece
    # it can't take on of its own pieces
    # it can't go off the board
  end
end
