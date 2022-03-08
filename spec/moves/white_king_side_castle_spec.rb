# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/square'
require_relative '../../lib/board'
require_relative '../../lib/castle_manager'
require_relative '../../lib/move'
require_relative '../../lib/moves/white_king_side_castle'

describe WhiteKingSideCastle do
  let(:board) { instance_double(Board, access_square: empty_square, square_under_attack_from_color?: false) }
  let(:empty_square) { instance_double(Square, unoccupied?: true, piece_color: nil) }
  let(:occupied_square) { instance_double(Square, unoccupied?: false, piece_color: 'white') }
  let(:color) { 'white' }
  let(:opposing_color) { 'black' }
  describe '#generate_moves' do
    context 'when there is no castle manager' do
      subject(:no_castling) { described_class.new(origin: 'E1', board: board, color: color) }
      it 'returns an empty array' do
        expect(no_castling.generate_moves).to be_empty
      end
    end

    context 'when there is a castle manager' do
      let(:castle_manager) { instance_double(CastleManager) }
      subject(:castle_move) do
        described_class.new(origin: 'E1', board: board, color: color, castle_manager: castle_manager)
      end
      context 'when castling is possible' do
        before do
          allow(castle_manager).to receive(:can_castle?).and_return(true)
        end

        it 'returns an array with G1' do
          expect(castle_move.generate_moves).to contain_exactly('G1')
        end
      end

      context 'when castling is not possible' do
        context 'when F1 is occupied' do
          before do
            allow(board).to receive(:access_square).with('F1').and_return(occupied_square)
            allow(castle_manager).to receive(:can_castle?).and_return(true)
          end

          it 'returns an empty array' do
            expect(castle_move.generate_moves).to be_empty
          end
        end

        context 'when E1 is under attack' do
          before do
            allow(board).to receive(:square_under_attack_from_color?).with(opposing_color, 'E1').and_return(true)
            allow(castle_manager).to receive(:can_castle?).and_return(true)
          end

          it 'returns an empty array' do
            expect(castle_move.generate_moves).to be_empty
          end
        end

        context 'when castle manager responds with false to can_castle?' do
          before do
            allow(castle_manager).to receive(:can_castle?).and_return(false)
          end

          it 'returns an empty array' do
            expect(castle_move.generate_moves).to be_empty
          end
        end
      end
    end
  end
end
