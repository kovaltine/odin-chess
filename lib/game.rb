# frozen_string_literal: true

# makes the board
def make_board
  empty_arr = Array.new(64)
  squares_arr = alternate_squares(empty_arr)
  board = unflatten_arr(squares_arr)
  draw_board(board)
end

# switches the square colour
def toggle_colours(index)
  black_square = "\u25A1"
  white_square = "\u25A0"
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
  puts "    #{numbers.join(' ')}"
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

make_board
