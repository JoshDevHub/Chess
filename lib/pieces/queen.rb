# frozen_string_literal: true

# Queen subclass to model behavior of the Queen chess piece
class Queen < Piece
  def initialize(color:, position:)
    super
    @name = 'queen'
  end

  FEN_CHARS = { white: 'Q', black: 'q' }.freeze
  UNICODES = { white: "\u2655", black: "\u265B" }.freeze

  def moves
    [DiagonalLineMove, CardinalLineMove]
  end
end
