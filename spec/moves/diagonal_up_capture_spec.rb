# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_up_capture'

describe DiagonalUpCapture do
  let(:board) { instance_double(Board, color_at: nil) }
  let(:color) { 'white' }
  let(:enemy_color) { 'black' }
  subject(:diagonal_capture) { described_class.new(color: color, origin: origin, board: board) }
  context 'when a piece is available for capture' do
    context 'when the origin is F3 and an enemy piece is on G4' do
      let(:origin) { 'F3' }
      before do
        allow(board).to receive(:color_at).with('G4').and_return(enemy_color)
      end

      it 'returns a list containg G4' do
        expect(diagonal_capture.generate_moves).to contain_exactly('G4')
      end
    end

    context 'when the origin is C5 and an enemy piece is on B6' do
      let(:origin) { 'C5' }
      before do
        allow(board).to receive(:color_at).with('B6').and_return(enemy_color)
      end

      it 'returns a list containing B6' do
        expect(diagonal_capture.generate_moves).to contain_exactly('B6')
      end
    end

    context 'when the origin is E6 and D7 and F7 both have enemy pieces' do
      let(:origin) { 'E6' }
      before do
        allow(board).to receive(:color_at).with('D7').and_return(enemy_color)
        allow(board).to receive(:color_at).with('F7').and_return(enemy_color)
      end

      it 'returns a list containing D7 and F7' do
        moves = %w[D7 F7]
        expect(diagonal_capture.generate_moves).to contain_exactly(*moves)
      end
    end
  end

  context 'when no piece is available for capture' do
    context 'when the origin is B3 with a friendly piece on A4' do
      let(:origin) { 'B3' }
      before do
        allow(board).to receive(:color_at).with('A4').and_return(color)
      end

      it 'returns an empty list' do
        expect(diagonal_capture.generate_moves).to be_empty
      end
    end
  end
end
