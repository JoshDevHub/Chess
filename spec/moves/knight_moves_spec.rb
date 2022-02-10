# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/move'
require_relative '../../lib/moves/knight_moves'

describe KnightMoves do
  let(:board) { double('board') }
  subject(:knight_list) { described_class.new(board) }
  context 'when the starting square is E4' do
    let(:square) { 'E4' }
    it 'will return a list that contains D6, F6, D2, F2, C5, G5, C3, and G3' do
      moves = %w[D6 F6 D2 F2 C5 G5 C3 G3]
      expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
    end
  end

  context 'when the piece is on A8 on an empty board' do
    let(:square) { 'A8' }
    it 'will return a list that contains B6 and C7' do
      moves = %w[B6 C7]
      expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
    end
  end

  context 'when the piece is on B1 on an empty board' do
    let(:square) { 'B1' }
    it 'will return a list that contains A3, D2, and C3' do
      moves = %w[A3 D2 C3]
      expect(knight_list.generate_moves(square)).to contain_exactly(*moves)
    end
  end
end
