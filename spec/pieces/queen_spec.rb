# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/queen'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_line_move'
require_relative '../../lib/moves/cardinal_line_move'

describe Queen do
  subject(:queen) { described_class.new(color: 'white', position: square) }
  let(:board) { instance_double(Board) }
  let(:diagonal_move_instance) { instance_double(DiagonalLineMove) }
  let(:cardinal_move_instance) { instance_double(CardinalLineMove) }
  describe '#move_list' do
    let(:square) { 'D1' }
    before do
      allow(DiagonalLineMove).to receive(:new).and_return(diagonal_move_instance)
      allow(diagonal_move_instance).to receive(:generate_moves).and_return([])

      allow(CardinalLineMove).to receive(:new).and_return(cardinal_move_instance)
      allow(cardinal_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of DiagonalLineMove' do
      expect(DiagonalLineMove).to receive(:new)
      queen.move_list(board)
    end

    it 'sends #generate_moves to the DiagonalLineMove instance' do
      expect(diagonal_move_instance).to receive(:generate_moves)
      queen.move_list(board)
    end

    it 'instantiates an instance of CardinalLineMove' do
      expect(CardinalLineMove).to receive(:new)
      queen.move_list(board)
    end

    it 'sends #generate_moves to the CardinalLineMove instance' do
      expect(cardinal_move_instance).to receive(:generate_moves)
      queen.move_list(board)
    end
  end
end
