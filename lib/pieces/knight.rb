# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def self.handles_notation?(char)
    %w[N n].include?(char)
  end
end
