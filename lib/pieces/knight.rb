# frozen_string_literal: true

# Knight subclass to model behavior of the Knight chess piece
class Knight < Piece
  def initialize(color:)
    super
    @name = 'knight'
  end

  def self.handles_notation?(char)
    %w[N n].include?(char)
  end

  private

  def knight_moves?
    true
  end
end
