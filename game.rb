# frozen_string_literal: true

require_relative './lib/chess'
require_relative './lib/board'

def start_game
  Chess.new
end

start_game
