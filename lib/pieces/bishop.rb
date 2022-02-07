# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def initialize(color:)
    super
  end

  def self.handles_notation?(char)
    %w[B b].include?(char)
  end

  def moves_diagonally?
    true
  end
end
