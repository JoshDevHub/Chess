# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/bishop'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_line_move'

describe Bishop do
  subject(:bishop) { described_class.new(color: 'white', position: square) }
  let(:board) { instance_double(Board, square_empty?: true) }
  let(:diagonal_move) { bishop.instance_variable_get(:@moves) }
  let(:diagonal_move_instance) { instance_double(DiagonalLineMove) }
  describe '#move_list' do
    let(:square) { 'C8' }
    before do
      allow(diagonal_move).to receive(:new).and_return(diagonal_move_instance)
      allow(diagonal_move_instance).to receive(:generate_moves)
    end

    it 'instantiates an instance of KnightMoves' do
      expect(diagonal_move).to receive(:new)
      bishop.move_list(board)
    end

    it 'sends #generate_moves to the KnightMoves instance' do
      expect(diagonal_move_instance).to receive(:generate_moves)
      bishop.move_list(board)
    end
  end
end
