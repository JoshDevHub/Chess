# frozen_string_literal: true

# Queen subclass to model behavior of the Queen chess piece
class Queen < Piece
  def initialize(color:)
    super
  end

  def self.handles_notation?(char)
    %w[Q q].include?(char)
  end
end
