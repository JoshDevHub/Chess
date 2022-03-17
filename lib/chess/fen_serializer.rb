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
      save_numbers = Dir.each_child('saved_games/').to_a.map(&:chr)
      game_number = ('1'..'5').find { |number| save_numbers.none?(number) } || '1'
      manage_save_files(game_number)
      white_player = instance_variable_get(:@player_white)
      black_player = instance_variable_get(:@player_black)
      filename = "saved_games/#{game_number}_#{white_player}_vs_#{black_player}.yaml"
      File.open(filename, 'w') { |file| file.puts yaml_string }
    end

    def manage_save_files(number)
      duplicate_dir = Dir.entries('saved_games/').find { |file| file.include?(number) }
      delete_save("saved_games/#{duplicate_dir}") if duplicate_dir
    end

    def delete_save(file_path)
      File.delete(file_path) if File.exist?(file_path)
    end

    def load_script
      load_file = load_game_selection
      file_path = "saved_games/#{load_file}"
      loaded_game = load_from_yaml(file_path)
      delete_save(file_path)
      loaded_game.game_script
    end

    def load_game_selection
      save_list = Dir.each_child('saved_games/').to_a
      return display.no_saves_error if save_list.empty?

      display.load_game_prompt(save_list)
      user_save_selection = choose_save(save_list)
      save_list.find { |save| save[0] == user_save_selection }
    end

    def choose_save(save_list)
      loop do
        user_input = gets.chomp
        return user_input if save_list.any? { |save| save[0] == user_input }

        display.input_error_message(:save_number)
      end
    end

    def load_from_yaml(file_path)
      data = YAML.load File.read(file_path)
      self.class.new(
        player_white: data[:player_white],
        player_black: data[:player_black],
        fen_string: data[:fen_string]
      )
    end
  end
end
