# frozen_string_literal:true

require 'colorize'

# .colorize(:yellow)
# .colorize(:light_blue)
# .colorize(:red)
# .colorize(:blue)

# display information in the console
module Display
  def puts_pieces_lost
    # system 'clear'
    puts "Casualties: #{@pieces_lost.join}\n"
  end

  def pick_team
    # system 'clear'
    puts "\nWould you like to play as Yellow or Blue?"
    gets.chomp
  end

  def end_message
    puts "\nCongratulations #{@team}, you won!"
  end

  def ask_for_move
    puts "\n#{@team}'s move"
    puts "\nEnter the coordinates of the piece you would like to move"
    puts 'Number first, then the letter'
  end

  def new_position
    puts "\nEnter the new coordinates"
    puts 'Number first, then the letter'
  end

  def cannot_move
    puts "\nSorry! This piece has no available moves".colorize(:red)
    puts 'Please try again'
  end

  def invalid_move
    puts "Sorry! You can't!".colorize(:red)
    puts 'Please try again'
  end

  def pick_another_piece
    puts "\nDo you want to select a different piece? Enter y/n".colorize(:blue)
    gets.chomp
  end

  def ask_for_move_computer
    puts "\n The computer is thinking"
    # these sleeps won't work
    puts '...'
    puts '...'
    puts '...'
  end
end
