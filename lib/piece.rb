# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  def initialize(color:)
    @color = color
  end

  def self.create(piece:, color:)
    raise NotImplementedError unless %w[white black].include?(color)

    {
      king: King,
      queen: Queen,
      rook: Rook,
      bishop: Bishop,
      knight: Knight,
      pawn: Pawn
    }[piece].new(color: color)
  rescue NoMethodError
    raise NotImplementedError
  end
end
