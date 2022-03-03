# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/rook'
require_relative '../../lib/move'
require_relative '../../lib/moves/cardinal_line_move'

describe Rook do
  subject(:rook) { described_class.new(color: 'black', position: square) }
  let(:board) { instance_double(Board) }
  describe '#move_list' do
    let(:cardinal_move_instance) { instance_double(CardinalLineMove) }
    let(:square) { 'A8' }
    before do
      allow(CardinalLineMove).to receive(:new).and_return(cardinal_move_instance)
      allow(cardinal_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of CardinalLineMove' do
      expect(CardinalLineMove).to receive(:new)
      rook.move_list(board)
    end

    it 'sends #generate_moves to the CardinalMoves instance' do
      expect(cardinal_move_instance).to receive(:generate_moves)
      rook.move_list(board)
    end
  end
end
