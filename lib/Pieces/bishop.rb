# frozen_string_literal:true

# determines the behaviour of bishop pieces
class Bishop
  def initialize(surrounding, square)
    @start = square
    @surrounding = surrounding
  end

  def bishop_pattern
    pos_y_pos_x = diagonal_pattern([1, 1])
    pos_y_pos_x_options = limit_axis_options(pos_y_pos_x)

    neg_y_pos_x = diagonal_pattern([-1, 1])
    neg_y_pos_x_options = limit_axis_options(neg_y_pos_x)

    pos_y_neg_x = diagonal_pattern([1, -1])
    pos_y_neg_x_options = limit_axis_options(pos_y_neg_x)

    neg_y_neg_x = diagonal_pattern([-1, -1])
    neg_y_neg_x_options = limit_axis_options(neg_y_neg_x)

    [pos_y_pos_x_options, neg_y_pos_x_options, pos_y_neg_x_options, neg_y_neg_x_options].flatten(1)
  end

  def king_pattern
    pos_y_pos_x = diagonal_pattern([1, 1])[0]
    pos_y_pos_x_options = limit_axis_options(pos_y_pos_x)

    neg_y_pos_x = diagonal_pattern([-1, 1])[0]
    neg_y_pos_x_options = limit_axis_options(neg_y_pos_x)

    pos_y_neg_x = diagonal_pattern([1, -1])[0]
    pos_y_neg_x_options = limit_axis_options(pos_y_neg_x)

    neg_y_neg_x = diagonal_pattern([-1, -1])[0]
    neg_y_neg_x_options = limit_axis_options(neg_y_neg_x)

    [pos_y_pos_x_options, neg_y_pos_x_options, pos_y_neg_x_options, neg_y_neg_x_options].flatten(1)
  end

  def diagonal_pattern(pattern, coord = @start.dup, bishop_line = [])
    return bishop_line unless (coord[0] + pattern[0]).between?(0, 7) && (coord[1] + pattern[1]).between?(0, 7)

    bishop_line.push([coord[0] += pattern[0], coord[1] += pattern[1]])

    diagonal_pattern(pattern, coord, bishop_line)
  end

  # if there's no surrounding of the same colour, then there are no axis limits
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
