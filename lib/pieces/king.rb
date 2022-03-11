# frozen_string_literal: true

# King subclass to model behavior of the King Chess piece
class King < Piece
  def initialize(color:, position:)
    super
    @name = 'king'
  end

  def self.handles_notation?(char)
    %w[K k].include?(char)
  end

  def moves
    [KingMove, KingSideCastle, QueenSideCastle]
  end

  def to_s
    color == 'white' ? " \u2654 " : " \u265A "
  end

  def involved_in_castling?
    true
  end

  def castle_move?(target)
    rank = color == 'white' ? '1' : '8'
    castle_origin, *castle_targets = %w[E C G].map { |file| file + rank }
    position == castle_origin && castle_targets.include?(target)
  end
end
