# frozen_string_literal: true

# class for handling King Side Castle moves for white
class WhiteKingSideCastle < Move
  def moveset
    [
      %i[right right]
    ]
  end

  private

  def legal_move?(_square)
    return false unless @castle_manager

    safe_castle_squares? && open_castle_squares? && @castle_manager.can_castle?(@color, :king)
  end

  def safe_castle_squares?
    %w[E1 F1 G1].none? do |castle_square|
      @board.square_under_attack_from_color?(opposing_color, castle_square)
    end
  end

  def open_castle_squares?
    %w[F1 G1].all? { |castle_square| @board.access_square(castle_square).unoccupied? }
  end
end
