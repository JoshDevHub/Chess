# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/king'
require_relative '../../lib/move'
require_relative '../../lib/moves/king_move'

describe King do
  subject(:king) { described_class.new(color: 'black', position: square) }
  let(:board) { instance_double(Board, square_empty?: true) }
  let(:king_move_instance) { instance_double(KingMove) }
  describe '#move_list' do
    let(:square) { 'E8' }
    before do
      allow(KingMove).to receive(:new).and_return(king_move_instance)
      allow(king_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of KingMove' do
      expect(KingMove).to receive(:new)
      king.move_list(board)
    end

    it 'sends #generate_moves to the KingMove instance' do
      expect(king_move_instance).to receive(:generate_moves)
      king.move_list(board)
    end
  end
end
