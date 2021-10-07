# frozen_string_literal: true

require_relative './lib/chess'
require_relative './lib/board'
require_relative './lib/chess_piece'

def start_game
  Chess.new
  puts 'Would you like to play again? y/n'
  if gets.chomp == 'y'
    start_game
  else
    puts 'Thanks for playing!'
  end
end

start_game
