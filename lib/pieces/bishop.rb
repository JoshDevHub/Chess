# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def initialize(color:)
    super
    @name = 'bishop'
  end

  def self.handles_notation?(char)
    %w[B b].include?(char)
  end

  def line_moves?
    true
  end

  private

  def moves_diagonally?
    true
  end
end
