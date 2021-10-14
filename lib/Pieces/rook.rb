# frozen_string_literal:true

# determines the behaviour of rook pieces
class Rook
  # returns arr of movement pattern
  def initialize(surrounding, square)
    @start = square
    @surrounding = surrounding
  end

  def rook_pattern
    move_positive_y = move_positive_y_direction
    move_negative_y = move_negative_y_direction
    move_positive_x = move_positive_x_direction
    move_negative_x = move_negative_x_direction
    [move_positive_y, move_negative_y, move_positive_x, move_negative_x].flatten(1)
  end

  def king_pattern
    move_positive_y = move_positive_y_direction[0]
    move_negative_y = move_negative_y_direction[0]
    move_positive_x = move_positive_x_direction[0]
    move_negative_x = move_negative_x_direction[0]
    [move_positive_y, move_negative_y, move_positive_x, move_negative_x].flatten(1)
  end

  def move_positive_y_direction
    positions = []
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
    return nil if arr.nil?
    return arr if @surrounding.nil?

    options = []
    arr.each do |option|
      options.push(option)
      return options if @surrounding.include?(option)
    end
  end
end
