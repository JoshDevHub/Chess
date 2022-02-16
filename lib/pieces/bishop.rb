# frozen_string_literal: true

# Bishop subclass to model behavior of the Bishop Chess piece
class Bishop < Piece
  def initialize(color:, position:)
    super
    @name = 'bishop'
  end

  MOVESET = [
    %i[up right],
    %i[up left],
    %i[down left],
    %i[down right]
  ].freeze

  def self.handles_notation?(char)
    %w[B b].include?(char)
  end

  def line_moves?
    true
  end
end
