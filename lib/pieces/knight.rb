# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def initialize(color:, position:)
    super
    @name = 'knight'
  end

  FEN_CHARS = { white: 'N', black: 'n' }.freeze

  def moves
    [KnightMoves]
  end

  def to_s
    color == 'white' ? " \u2658 " : " \u265E "
  end
end
