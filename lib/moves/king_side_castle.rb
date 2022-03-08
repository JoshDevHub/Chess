# frozen_string_literal: true

# class for handling King Side Castle moves for white
class KingSideCastle < Move
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
    squares_needing_safety_for_castling.none? do |castle_square|
      @board.square_under_attack_from_color?(opposing_color, castle_square)
    end
  end

  def open_castle_squares?
    squares_needing_to_be_empty_for_castling.all? do |castle_square|
      @board.access_square(castle_square).unoccupied?
    end
  end

  def squares_needing_safety_for_castling
    %w[E F G].map { |square| @color == 'white' ? "#{square}1" : "#{square}8" }
  end

  def squares_needing_to_be_empty_for_castling
    %w[F G].map { |square| @color == 'white' ? "#{square}1" : "#{square}8" }
  end
end
