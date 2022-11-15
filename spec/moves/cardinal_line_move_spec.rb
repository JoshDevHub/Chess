# frozen_string_literal: true

RSpec.describe CardinalLineMove do
  subject(:cardinal_line) { described_class.new(color: 'black', origin: origin, board: board) }
  let(:board) { instance_double(Board, access_square: square) }
  let(:square) { instance_double(Square, unoccupied?: true, piece_color: nil) }
  describe '#generate_moves' do
    context 'when no friendly piece is blocking any squares' do
      context 'when the starting square is A8' do
        let(:origin) { 'A8' }
        it 'returns a list containing A7, A6, A5, A4, A3, A2, A1, B8, C8, D8, E8,
          F8, G8, and H8' do
          moves = %w[A7 A6 A5 A4 A3 A2 A1 B8 C8 D8 E8 F8 G8 H8]
          expect(cardinal_line.generate_moves).to contain_exactly(*moves)
        end
      end
    end

    context 'when friendly pieces are blocking squares' do
      let(:block_color) { 'black' }
      let(:block_square) { instance_double(Square, unoccupied?: false, piece_color: block_color) }
      context 'when the starting square is C6 and B6 and D6 are blocked' do
        let(:origin) { 'C6' }
        before do
          allow(board).to receive(:access_square).with('B6').and_return(block_square)
          allow(board).to receive(:access_square).with('D6').and_return(block_square)
        end

        it 'returns a list containing C7, C8, C5, C4, C3, C2, and C1' do
          moves = %w[C7 C8 C5 C4 C3 C2 C1]
          expect(cardinal_line.generate_moves).to contain_exactly(*moves)
        end
      end
    end

    context 'when the piece is completely boxed in by friendly pieces' do
      let(:block_color) { 'black' }
      let(:block_square) { instance_double(Square, unoccupied?: false, piece_color: block_color) }
      context 'when the starting square is H8 and H7 and G8 are blocked' do
        let(:origin) { 'H8' }
        before do
          allow(board).to receive(:access_square).with('H7').and_return(block_square)
          allow(board).to receive(:access_square).with('G8').and_return(block_square)
        end

        it 'returns an empty array' do
          expect(cardinal_line.generate_moves).to be_empty
        end
      end
    end

    context 'when a piece is available for capture' do
      let(:capture_color) { 'white' }
      let(:capture_square) { instance_double(Square, unoccupied?: false, piece_color: capture_color) }
      context 'when the origin is H4 and an enemy piece is on F4' do
        let(:origin) { 'H4' }
        before do
          allow(board).to receive(:access_square).with('F4').and_return(capture_square)
        end

        it 'returns a list with H1, H2, H3, H5, H6, H7, H8, G4 and F4' do
          moves = %w[H1 H2 H3 H5 H6 H7 H8 G4 F4]
          expect(cardinal_line.generate_moves).to contain_exactly(*moves)
        end
      end
    end
  end
end
