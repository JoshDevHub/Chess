# frozen_string_literal: true

RSpec.describe BlackPawnCapture do
  subject(:diagonal_capture) { described_class.new(color: color, origin: origin, board: board) }

  let(:board) { instance_double(Board, access_square: square, en_passant_target: nil) }
  let(:square) { instance_double(Square, piece_color: nil) }
  let(:color) { 'black' }
  let(:enemy_color) { 'white' }
  let(:enemy_square) { instance_double(Square, piece_color: enemy_color) }

  context 'when a piece is available for capture' do
    context 'when the origin is F3 and an enemy piece is on G2' do
      let(:origin) { 'F3' }

      before do
        allow(board).to receive(:access_square).with('G2').and_return(enemy_square)
      end

      it 'returns a list containg G2' do
        expect(diagonal_capture.generate_moves).to contain_exactly('G2')
      end
    end

    context 'when the origin is C5 and an enemy piece is on B4' do
      let(:origin) { 'C5' }

      before do
        allow(board).to receive(:access_square).with('B4').and_return(enemy_square)
      end

      it 'returns a list containing B4' do
        expect(diagonal_capture.generate_moves).to contain_exactly('B4')
      end
    end

    context 'when the origin is E6 and D5 and F5 both have enemy pieces' do
      let(:origin) { 'E6' }

      before do
        allow(board).to receive(:access_square).with('D5').and_return(enemy_square)
        allow(board).to receive(:access_square).with('F5').and_return(enemy_square)
      end

      it 'returns a list containing D5 and F5' do
        moves = %w[D5 F5]
        expect(diagonal_capture.generate_moves).to match_array(moves)
      end
    end

    context 'when the origin is E4 and a D3 is available for en passant capture' do
      let(:origin) { 'E4' }

      before do
        allow(board).to receive(:en_passant_target).and_return('D3')
      end

      it 'returns a list containing D3' do
        expect(diagonal_capture.generate_moves).to contain_exactly('D3')
      end
    end
  end

  context 'when no piece is available for capture' do
    context 'when the origin is B3 with a friendly piece on A2' do
      let(:origin) { 'B3' }

      it 'returns an empty list' do
        expect(diagonal_capture.generate_moves).to be_empty
      end
    end
  end
end
