# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  def initialize(color:)
    @color = color
  end

  def self.create(piece:, color:)
    {
      king: King,
      queen: Queen,
      rook: Rook,
      bishop: Bishop,
      knight: Knight,
      pawn: Pawn
    }[piece].new(color: color)
  end
end
