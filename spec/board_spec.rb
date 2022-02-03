# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#game_board' do
    subject(:board) { described_class.new }
    let(:square) { double('square') }
    xit 'returns a 2d array with an outer size of 8' do
      expect(board.game_board.size).to eq(8)
    end

    xit 'returns a 2d array with an inner size of 8' do
      expect(board.game_board.all? { |inner| inner.size == 8 }).to be(true)
    end

    xit 'returns a structure with 64 square objects' do
      square_count = game_board.flatten.count(square)
      expect(square_count).to eq(64)
    end
  end
end
