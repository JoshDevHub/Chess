# frozen_string_literal: true

require_relative 'lib/coordinate'
require_relative 'lib/chess/fen_serializer'
Dir[File.join(__dir__, '/lib/**', '*.rb')].sort.each { |file| require file }

Chess.new.play
