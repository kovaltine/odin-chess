# frozen_string_literal: true

require_relative './lib/chess'
require_relative './lib/board'
require_relative './lib/chess_piece'

def start_game
  Chess.new
end

start_game
