# frozen_string_literal: true

black_positions = [
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

# c, k, b, q, k, b, k ,c, p
white_positions = [
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

# creates the board with starting positions
def chess_board(black_positions, white_positions)
  # a grid of 8x8 coloured squares
  board = make_board
  # add the chess pieces
  board_with_black = add_pieces(board, black_positions)
  board_black_white = add_pieces(board_with_black, white_positions)
  draw_board(board_black_white)
end

# makes the board
def make_board
  empty_arr = Array.new(64)
  squares_arr = alternate_squares(empty_arr)
  unflatten_arr(squares_arr)
end

def add_pieces(arr, positions)
  board = arr
  positions.map do |piece|
    board[piece[1]][piece[2]] = piece[0]
  end
  board
end

# switches the square colour
def toggle_colours(index)
  black_square = " \u25A1"
  white_square = " \u25A0"
  arr = [black_square, white_square]
  arr[index]
end

# switches the index
def toggle_index(index)
  case index
  when 0
    index = 1
  when 1
    index = 0
  end
  index
end

# draws the board with coordinates
def draw_board(board)
  letters = %w[a b c d e f g h]
  numbers = %w[1 2 3 4 5 6 7 8]
  i = 0
  board.each do |row|
    puts "#{letters[i]} | #{row.join(' ')} |"
    i += 1
  end
  puts "     #{numbers.join('  ')}"
end

# adds a different square colour
def alternate_squares(arr)
  index = 0
  square_count = 0
  arr.map do
    if square_count < 8
      square_count += 1
      index = toggle_index(index)
      toggle_colours(index)
      # every 8th item, don't switch the square colour
    elsif square_count == 8
      square_count = 1
      toggle_colours(index)
    end
  end
end

# creates a 2d arr  of 8X8 from a 1d array of 64
def unflatten_arr(arr)
  board = []
  row = []
  arr.map do |square|
    row.push(square)
    if row.length == 8
      board.push(row)
      row = []
    end
  end
  board
end

chess_board(black_positions, white_positions)
