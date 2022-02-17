# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def initialize(color:, position:)
    super
    @name = 'rook'
  end

  def self.handles_notation?(char)
    %w[R r].include?(char)
  end

  def moveset
    [
      %i[up],
      %i[down],
      %i[left],
      %i[right]
    ]
  end

  def to_s
    color == 'white' ? "\u2656" : "\u265C"
  end

  private

  def line_moves?
    true
  end
end
