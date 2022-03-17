# frozen_string_literal: true

require 'yaml'

# written as an extension of Chess -- can't exist outside this context
class Chess
  # handles serialization to and from FEN strings
  module FENSerializer
    def game_to_fen
      en_passant_square = instance_variable_get(:@chess_board).en_passant_target || '-'
      board_fen = instance_variable_get(:@chess_board).to_fen
      active_color = instance_variable_get(:@active_color).chr
      castle_fen = instance_variable_get(:@castle_manager).to_fen
      half_move_fen = instance_variable_get(:@half_move_clock)
      full_move_fen = instance_variable_get(:@full_move_clock)
      "#{board_fen} #{active_color} #{castle_fen} #{en_passant_square} #{half_move_fen} "\
        "#{full_move_fen}"
    end

    def game_to_yaml
      save_object = {}
      save_object[:fen_string] = game_to_fen
      save_object[:player_white] = instance_variable_get(:@player_white)
      save_object[:player_black] = instance_variable_get(:@player_black)
      YAML.dump save_object
    end

    def save_game
      yaml_string = game_to_yaml
      Dir.mkdir('../saved_games') unless Dir.exist?('../saved_games')
      directory_size = Dir.entries('../saved_games').size
      game_number = directory_size >= 5 ? 1 : directory_size
      white_player = instance_variable_get(:@player_white)
      black_player = instance_variable_get(:@player_black)
      filename = "saved_games/#{game_number}_#{white_player}_vs_#{black_player}.yaml"
      File.open(filename, 'w') { |file| file.puts yaml_string }
    end
  end
end
