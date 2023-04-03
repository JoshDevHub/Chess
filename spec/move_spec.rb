# frozen_string_literal: true

RSpec.describe Move do
  subject(:move_super) { described_class.new(origin: origin, board: board, color: color) }

  let(:origin) { 'A1' }
  let(:board) { instance_double(Board) }
  let(:color) { 'white' }

  describe '#move_set' do
    it 'returns an empty array' do
      expect(move_super.generate_moves).to be_empty
    end
  end

  describe '#generate_moves' do
    it 'returns an empty array' do
      expect(move_super.generate_moves).to be_empty
    end
  end
end
