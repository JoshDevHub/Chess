# frozen_string_literal: true

# modules
require_relative 'colorize_output'
require_relative 'coordinate'
require_relative 'game/fen_serializer'

# base classes
require_relative 'board'
require_relative 'castle_manager'
require_relative 'display'
require_relative 'fen'
require_relative 'game'
require_relative 'move'
require_relative 'move_interface'
require_relative 'piece'
require_relative 'player'
require_relative 'square'

# piece subclasses
require_relative 'pieces/bishop'
require_relative 'pieces/black_pawn'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/null_piece'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/white_pawn'

# move subclasses
require_relative 'moves/black_pawn_advance'
require_relative 'moves/black_pawn_capture'
require_relative 'moves/black_pawn_double_advance'
require_relative 'moves/cardinal_line_move'
require_relative 'moves/diagonal_line_move'
require_relative 'moves/king_move'
require_relative 'moves/king_side_castle'
require_relative 'moves/knight_moves'
require_relative 'moves/queen_side_castle'
require_relative 'moves/white_pawn_advance'
require_relative 'moves/white_pawn_capture'
require_relative 'moves/white_pawn_double_advance'

# move interface subclasses
require_relative 'move_interfaces/move_inline_interface'
require_relative 'move_interfaces/move_list_interface'
