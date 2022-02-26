# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/black_pawn_capture'

describe BlackPawnCapture do
  let(:board) { instance_double(Board, color_at: nil) }
  let(:color) { 'black' }
  let(:enemy_color) { 'white' }
  subject(:diagonal_capture) { described_class.new(color: color, origin: origin, board: board) }
  context 'when a piece is available for capture' do
    context 'when the origin is F3 and an enemy piece is on G2' do
      let(:origin) { 'F3' }
      before do
        allow(board).to receive(:color_at).with('G2').and_return(enemy_color)
      end

      it 'returns a list containg G2' do
        expect(diagonal_capture.generate_moves).to contain_exactly('G2')
      end
    end

    context 'when the origin is C5 and an enemy piece is on B4' do
      let(:origin) { 'C5' }
      before do
        allow(board).to receive(:color_at).with('B4').and_return(enemy_color)
      end

      it 'returns a list containing B4' do
        expect(diagonal_capture.generate_moves).to contain_exactly('B4')
      end
    end

    context 'when the origin is E6 and D5 and F5 both have enemy pieces' do
      let(:origin) { 'E6' }
      before do
        allow(board).to receive(:color_at).with('D5').and_return(enemy_color)
        allow(board).to receive(:color_at).with('F5').and_return(enemy_color)
      end

      it 'returns a list containing D5 and F5' do
        moves = %w[D5 F5]
        expect(diagonal_capture.generate_moves).to contain_exactly(*moves)
      end
    end
  end

  context 'when no piece is available for capture' do
    context 'when the origin is B3 with a friendly piece on A2' do
      let(:origin) { 'B3' }
      before do
        allow(board).to receive(:color_at).with('A2').and_return(color)
      end

      it 'returns an empty list' do
        expect(diagonal_capture.generate_moves).to be_empty
      end
    end
  end
end
