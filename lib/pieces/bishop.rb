# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def initialize(color:, position:)
    super
    @name = 'bishop'
  end

  FEN_CHARS = { white: 'B', black: 'b' }.freeze

  def moves
    [DiagonalLineMove]
  end

  def to_s
    color == 'white' ? " \u2657 " : " \u265D "
  end
end
