# frozen_string_literal: true

require 'yaml'
require_relative 'chess'
require_relative 'display'
require 'colorize'

# for saving games so they can be played later
module Database
  def type_filename
    puts 'Type what you want the save file to be called'.colorize(:light_blue)
    name = gets.chomp.concat('_game.yaml')
    while @filenames.include? name
      puts 'That file already exists'.colorize(:red)
      puts 'please type a different name'.colorize(:light_blue)
      name = gets.chomp.concat('_game.yaml')
    end
    @filenames.push(name)
    name
  end

  def save_file
    Dir.mkdir('saves') unless Dir.exist?('saves')
    filename = type_filename
    File.open("saves/#{filename}", 'w') { |file| file.write save_to_yaml }
    display_saved_end
  end

  def save_to_yaml
    YAML.dump(
      'chess_pieces' => @chess_pieces,
      'pieces_lost' => @pieces_lost,
      'computer' => @computer_team,
      'player' => @player_team,
      'current_turn' => @team
    )
  end

  def find_saved_file
    show_file_list
    file_number = user_input
    @saved_game = file_list[file_number.to_i - 1] unless file_number == 'exit'
  end

  def user_input
    puts 'enter a number to retrieve your save file'.colorize(:light_blue)
    gets.chomp.to_i
  end

  def show_file_list
    puts "\n"
    puts display_saved_games('#', 'File Name(s)')
    file_list.each_with_index do |name, index|
      display_saved_games((index + 1).to_s, name.to_s)
    end
  end

  def display_saved_games(number, name)
    puts "#{number}:       #{name}"
  end

  def file_list
    files = []
    Dir.entries('saves').each do |name|
      files << name if name.match(/(game)/)
    end
    files
  end

  def load_file
    find_saved_file
    load_saved_file
    File.delete("saves/#{@saved_game}") if File.exist?("saves/#{@saved_game}")
  rescue StandardError
    puts display_load_error
  end

  def display_load_error
    puts 'There was an error loading your game'.colorize(:red)
  end

  def load_saved_file
    file = YAML.safe_load(File.read("saves/#{@saved_game}"))
    @chess_pieces = file['chess_pieces']
    @pieces_lost = file['pieces_lost']
    @computer_team = file['computer']
    @player_team = file['player']
    @team = file['current_turn']
  end
end
