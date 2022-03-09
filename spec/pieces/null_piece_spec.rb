# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/null_piece'

describe NullPiece do
  subject(:null_piece) { described_class.new(color: 'red', position: 'A1') }
  describe '#name' do
    it 'returns nil' do
      expect(null_piece.name).to be(nil)
    end
  end

  describe '#color' do
    it 'returns nil' do
      expect(null_piece.color).to be(nil)
    end
  end

  describe '#en_passant_target' do
    it 'returns nil' do
      expect(null_piece.en_passant_target).to be(nil)
    end
  end

  describe '#moves' do
    it 'returns an empty array' do
      expect(null_piece.moves).to be_empty
    end
  end

  describe '#move_list' do
    # not verifying doubles because they are unusued in the method definition
    let(:board) { double('board') }
    let(:castle_manager) { double('castle_manager') }
    it 'returns an empty array' do
      expect(null_piece.move_list(board, castle_manager)).to be_empty
    end
  end

  describe '#to_s' do
    it 'returns a string with three spaces' do
      expected_string = '   '
      expect(null_piece.to_s).to eq(expected_string)
    end
  end

  describe '#opponent_color' do
    it 'returns nil' do
      expect(null_piece.opponent_color).to be(nil)
    end
  end

  describe '#move_position' do
    it 'returns nil' do
      expect(null_piece.position).to be(nil)
    end
  end

  describe '#absent?' do
    it 'returns true' do
      expect(null_piece.absent?).to be(true)
    end
  end
end
