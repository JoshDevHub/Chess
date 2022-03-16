# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def initialize(color:, position:)
    super
    @name = 'knight'
  end

  FEN_CHARS = { white: 'N', black: 'n' }.freeze
  UNICODES = { white: "\u2658", black: "\u265E" }.freeze

  def moves
    [KnightMoves]
  end
end
