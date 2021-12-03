# frozen_string_literal:true

require_relative './board'
require_relative './chess_pieces'
require_relative './surrounding_piece'
require_relative './display'
require_relative './human'
require_relative './computer'
require_relative 'database'

# plays the chess game
class Chess
  # include Board
  include ChessPieces
  include SurroundingPiece
  include Display
  include Database

  def initialize
    @chess_pieces = start_chess_pieces
    @pieces_lost = []
    @filenames = []
    @team = 'Blue'
    load_game
    play_game
  end

  def play_game
    board = Board.new
    i = 1
    @saved = false
    until team_lost? || @saved
      puts_pieces_lost
      board.chess_board(@chess_pieces)
      @chess_pieces = make_a_move
      @team = toggle_team
      i += increment_player_round
      # board.chess_board(@chess_pieces)
      @saved = check_save(i)
    end
    end_game
  end

  def end_game
    if team_lost?
      end_message
    elsif @saved
      display_saved_end
    end
  end

  def increment_player_round
    return 1 if @team == @player_team

    0
  end

  # make sure it's the player's turn before you ask if they want to save
  def check_save(index)
    return false unless @team == @player_team && (index % 3).zero?

    save_game? ? keep_playing? : false
  end

  def keep_playing?
    puts 'would you like to keep playing?'
    input = gets.chomp.downcase
    return true unless input == 'y'

    false
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
    case input.downcase
    when 'yellow'
      @comp_team = 'Blue'
      @player_team = 'Yellow'
    when 'blue'
      @player_team = 'Blue'
      @comp_team = 'Yellow'
    else
      puts "please enter 'Yellow' or 'Blue'"
      choose_team
    end
  end

  def load_game
    puts 'would you like to load a game from a saved file?'
    input = gets.chomp.downcase
    case input
    when 'y'
      choose_team unless load_file

    else
      choose_team
    end
    determine_computer
    determine_human
  end

  def save_game?
    puts 'would you like to save your game?'
    input = gets.chomp.downcase
    case input
    when 'y'
      save_file
      true
    else
      false
    end
  end

  def make_a_move
    selection = player_turn
    player_turn while selection.nil?
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
      ask_for_move_computer
      @computer.select_piece(@chess_pieces, @pieces_lost)
    end
  end

  def move_piece(selection)
    surrounding_pieces = surrounding_board_pieces(selection)
    move_arr = movement_pattern(selection, surrounding_pieces)
    if @team == @player_team
      @human.check_piece_options(move_arr) ? @human.new_piece_position(selection, move_arr) : player_turn
    elsif @team == @comp_team
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
