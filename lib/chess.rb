# frozen_string_literal:true

require_relative './board'
require_relative './chess_pieces'
require_relative './surrounding_piece'
require_relative './display'
require_relative './human'
require_relative './computer'

# plays the chess game
class Chess
  # include Board
  include ChessPieces
  include SurroundingPiece
  include Display

  def initialize
    @chess_pieces = start_chess_pieces
    @pieces_lost = []
    choose_team
    determine_computer
    determine_human
    @team = 'Blue'
    play_game
  end

  def determine_computer
    @computer = Computer.new
    @computer.colour = @comp_team
  end

  def determine_human
    @human = Human.new
    @human.colour = @player_team
  end

  def choose_team
    input = pick_team
    case input
    when 'Yellow'
      @comp_team = 'Blue'
      @player_team = 'Yellow'
    when 'Blue'
      @player_team = 'Blue'
      @comp_team = 'Yellow'
    else
      puts "please enter 'Yellow' or 'Blue'"
      choose_team
    end
  end

  # BUG! freezes when you pick the other team
  def play_game
    board = Board.new
    until team_lost?
      puts_pieces_lost
      board.chess_board(@chess_pieces)
      @chess_pieces = make_a_move
      @team = toggle_team
    end
    end_message
  end

  def make_a_move
    selection = player_turn
    chess_hash = move_piece(selection)
    until chess_hash.is_a?(Hash)
      selection = player_turn
      chess_hash = move_piece(selection)
    end
    chess_hash
  end

  def player_turn
    if @team == @player_team
      @human.select_piece(@chess_pieces, @pieces_lost)
    elsif @team == @comp_team
      @computer.select_piece(@chess_pieces, @pieces_lost)
    end
  end

  def move_piece(selection)
    surrounding_pieces = surrounding_board_pieces(selection)
    move_arr = movement_pattern(selection, surrounding_pieces)
    if @team == @player_team
      p "human move_arr #{move_arr}"
      @human.check_piece_options(move_arr) ? @human.new_piece_position(selection, move_arr) : player_turn
    elsif @team == @comp_team
      p "computer move_arr #{move_arr}"
      @computer.check_piece_options(move_arr) ? @computer.update_position : false
    end
  end

  def toggle_team
    case @team
    when 'Blue'
      'Yellow'
    when 'Yellow'
      'Blue'
    end
  end

  # the exit condition will be if one of the players has lost their king
  def team_lost?
    return false if @chess_pieces.key?('yellow_king') && @chess_pieces.key?('blue_king')

    true
  end

  # find the surrounding chess pieces
  def surrounding_board_pieces(coord)
    board_pieces = make_board_piece_arr
    surrounding_pieces(board_pieces, coord)
  end

  def make_board_piece_arr
    board_pieces = []
    @chess_pieces.each_pair do |_key, value|
      value.each_pair do |property, data|
        next unless property == 'square'

        board_pieces.push(data)
      end
    end
    board_pieces.flatten(1)
  end
end
