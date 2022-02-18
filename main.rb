# frozen_string_literal: true

require_relative 'lib/coordinate'
Dir[File.join(__dir__, '/lib/**', '*.rb')].sort.each { |file| require file }

Chess.new.play_chess
