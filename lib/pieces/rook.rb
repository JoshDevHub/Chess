# frozen_string_literal: true

# Rook subclass to model behavior of the Rook chess piece
class Rook < Piece
  def initialize(color:)
    super
  end

  def self.handles_notation?(char)
    %w[R r].include?(char)
  end
end
