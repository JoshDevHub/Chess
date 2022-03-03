# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/square'
require_relative '../../lib/board'
require_relative '../../lib/move'
require_relative '../../lib/moves/white_pawn_capture'

describe WhitePawnCapture do
  let(:board) { instance_double(Board, access_square: square, en_passant_target: nil) }
  let(:enemy_color) { 'black' }
  let(:square) { instance_double(Square, piece_color: nil) }
  let(:color) { 'white' }
  let(:enemy_color) { 'black' }
  let(:enemy_square) { instance_double(Square, piece_color: enemy_color) }
  subject(:diagonal_capture) { described_class.new(color: color, origin: origin, board: board) }
  context 'when a piece is available for capture' do
    context 'when the origin is F3 and an enemy piece is on G4' do
      let(:origin) { 'F3' }
      before do
        allow(board).to receive(:access_square).with('G4').and_return(enemy_square)
      end

      it 'returns a list containg G4' do
        expect(diagonal_capture.generate_moves).to contain_exactly('G4')
      end
    end

    context 'when the origin is C5 and an enemy piece is on B6' do
      let(:origin) { 'C5' }
      before do
        allow(board).to receive(:access_square).with('B6').and_return(enemy_square)
      end

      it 'returns a list containing B6' do
        expect(diagonal_capture.generate_moves).to contain_exactly('B6')
      end
    end

    context 'when the origin is E6 and D7 and F7 both have enemy pieces' do
      let(:origin) { 'E6' }
      before do
        allow(board).to receive(:access_square).with('D7').and_return(enemy_square)
        allow(board).to receive(:access_square).with('F7').and_return(enemy_square)
      end

      it 'returns a list containing D7 and F7' do
        moves = %w[D7 F7]
        expect(diagonal_capture.generate_moves).to contain_exactly(*moves)
      end
    end

    context 'when the origin is B5 and C6 is available for en passant capture' do
      let(:origin) { 'B5' }
      before do
        allow(board).to receive(:en_passant_target).and_return('C6')
      end

      it 'returns a list containing C6' do
        expect(diagonal_capture.generate_moves).to contain_exactly('C6')
      end
    end
  end

  context 'when no piece is available for capture' do
    context 'when the origin is B3 with a friendly piece on A4' do
      let(:origin) { 'B3' }

      it 'returns an empty list' do
        expect(diagonal_capture.generate_moves).to be_empty
      end
    end
  end
end
