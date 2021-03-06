# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/knight'
require_relative '../../lib/move'
require_relative '../../lib/moves/knight_moves'

describe Knight do
  describe '#move_list' do
    subject(:knight) { described_class.new(color: 'black', position: square) }
    let(:board) { instance_double(Board) }
    let(:knight_move_instance) { instance_double(KnightMoves) }
    let(:square) { 'B1' }
    before do
      allow(KnightMoves).to receive(:new).and_return(knight_move_instance)
      allow(knight_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of KnightMoves' do
      expect(KnightMoves).to receive(:new)
      knight.move_list(board)
    end

    it 'sends #generate_moves to the KnightMoves instance' do
      expect(knight_move_instance).to receive(:generate_moves)
      knight.move_list(board)
    end
  end

  describe '#to_fen' do
    subject(:knight) { described_class.new(color: color, position: 'E4') }
    context 'when the knight is white' do
      let(:color) { 'white' }
      it "returns the string 'N'" do
        expected_string = 'N'
        expect(knight.to_fen).to eq(expected_string)
      end
    end

    context 'when the knight is black' do
      let(:color) { 'black' }
      it "returns the string 'n'" do
        expected_string = 'n'
        expect(knight.to_fen).to eq(expected_string)
      end
    end
  end
end
