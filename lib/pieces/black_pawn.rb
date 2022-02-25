# frozen_string_literal: true

# class for handling pawns with the color black
class BlackPawn < Piece
  def initialize(color:, position:)
    super
    @name = 'pawn'
  end

  def self.handles_notation?(char)
    char == 'p'
  end

  def moves
    list = [OneDownMove, DiagonalDownCapture]
    list << DoubleDownMove if double_move?
    list
  end

  def to_s
    "\u265F"
  end

  def position=(new_position)
    @en_passant_target = "#{position[0]}6" if double_move_executed?(new_position)
    @position = new_position
  end

  private

  def double_move?
    position[1] == '7'
  end

  def double_move_executed?(move)
    position[1] == '7' && move[1] == '5'
  end
end
