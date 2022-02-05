# frozen_string_literal: true

# King subclass to model behavior of the King Chess piece
class King < Piece
  def initialize(color:)
    super
  end

  def self.handles_notation?(char)
    %w[K k].include?(char)
  end
end
