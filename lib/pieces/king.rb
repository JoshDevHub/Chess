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
    list = [KingMove]
    list.push(WhiteKingSideCastle, WhiteQueenSideCastle) if @color == 'white'
  end

  def to_s
    color == 'white' ? "\u2654" : "\u265A"
  end
end
