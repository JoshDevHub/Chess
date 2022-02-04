# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  private_class_method def self.pieces
    {
      king: King,
      queen: Queen,
      rook: Rook,
      bishop: Bishop,
      knight: Knight,
      pawn: Pawn
    }
  end

  def self.new_piece(piece:, color:)
    raise NotImplementedError unless %w[white black].include?(color)

    pieces[piece].new(color: color)
  rescue NoMethodError
    raise NotImplementedError
  end
end
