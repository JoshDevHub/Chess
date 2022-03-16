# frozen_string_literal: true

# Parent Piece class for game pieces to inherit from
class Piece
  attr_reader :color, :position, :name, :en_passant_target

  include Coordinate

  def initialize(color:, position:)
    raise NotImplementedError unless COLORS.include?(color)

    @color = color
    @position = position
    @name = 'piece'
    @en_passant_target = nil
  end

  COLORS = %w[white black].freeze
  FEN_CHARS = {}.freeze
  UNICODES = {}.freeze

  def self.handles_notation?(char)
    self::FEN_CHARS.values.include?(char)
  end

  def moves
    []
  end

  def move_list(board, castle_manager = nil)
    moves.each_with_object([]) do |move, list|
      generator = move.new(origin: position, board: board, color: color, castle_manager: castle_manager)
      list.concat(generator.generate_moves)
    end
  end

  def to_s
    unicode_char = self.class::UNICODES[color.to_sym]
    " #{unicode_char} "
  end

  def opponent_color
    color == 'white' ? 'black' : 'white'
  end

  def self.from_fen(char, square)
    color = char == char.upcase ? 'white' : 'black'
    [King, Queen, Rook, Bishop, Knight, WhitePawn, BlackPawn]
      .find { |piece_type| piece_type.handles_notation?(char) }.new(color: color, position: square)
  rescue NoMethodError
    puts 'This piece is not supported'
    raise NotImplementedError
  end

  def move_position(target_position)
    @position = target_position
  end

  def define_en_passant_square(_square)
    nil
  end

  def capture_en_passant?(_square)
    false
  end

  def can_promote?
    false
  end

  def involved_in_castling?
    false
  end

  def castle_move?(_target)
    false
  end

  def disable_castle_rights(_castle_manager)
    nil
  end

  def move_resets_clock?
    false
  end

  def absent?
    false
  end

  def to_fen
    self.class::FEN_CHARS[color.to_sym]
  end
end
