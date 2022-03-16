# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def initialize(color:, position:)
    super
    @name = 'bishop'
  end

  FEN_CHARS = { white: 'B', black: 'b' }.freeze
  UNICODES = { white: "\u2657", black: "\u265D" }.freeze

  def moves
    [DiagonalLineMove]
  end
end
