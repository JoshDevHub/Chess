# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/knight'
require_relative '../../lib/move'
require_relative '../../lib/moves/knight_moves'

describe Knight do
  subject(:knight) { described_class.new(color: 'black', position: square) }
  let(:board) { instance_double(Board, square_empty?: true) }
  let(:knight_moves) { knight.instance_variable_get(:@moves)[0] }
  let(:knight_move_instance) { instance_double(KnightMoves) }
  describe '#move_list' do
    let(:square) { 'B1' }
    before do
      allow(knight_moves).to receive(:new).and_return(knight_move_instance)
      allow(knight_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of KnightMoves' do
      expect(knight_moves).to receive(:new)
      knight.move_list(board)
    end

    it 'sends #generate_moves to the KnightMoves instance' do
      expect(knight_move_instance).to receive(:generate_moves)
      knight.move_list(board)
    end
  end
end
