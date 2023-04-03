# frozen_string_literal: true

RSpec.describe KingSideCastle do
  let(:board) { instance_double(Board, access_square: empty_square, square_under_attack_from_color?: false) }
  let(:empty_square) { instance_double(Square, unoccupied?: true, piece_color: nil) }
  let(:occupied_square) { instance_double(Square, unoccupied?: false, piece_color: 'white') }

  describe '#generate_moves' do
    context 'when the color is white' do
      let(:color) { 'white' }
      let(:opposing_color) { 'black' }

      context 'when there is no castle manager' do
        subject(:no_castling) { described_class.new(origin: 'E1', board: board, color: color) }

        it 'returns an empty array' do
          expect(no_castling.generate_moves).to be_empty
        end
      end

      context 'when there is a castle manager' do
        subject(:castle_move) do
          described_class.new(origin: 'E1', board: board, color: color, castle_manager: castle_manager)
        end

        let(:castle_manager) { instance_double(CastleManager) }

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

    context 'when the color is black' do
      let(:color) { 'black' }
      let(:opposing_color) { 'white' }

      context 'when there is no castle manager' do
        subject(:no_castling) { described_class.new(origin: 'E8', board: board, color: color) }

        it 'returns an empty array' do
          expect(no_castling.generate_moves).to be_empty
        end
      end

      context 'when there is a castle manager' do
        subject(:castle_move) do
          described_class.new(origin: 'E8', board: board, color: color, castle_manager: castle_manager)
        end

        let(:castle_manager) { instance_double(CastleManager) }

        context 'when castling is possible' do
          before do
            allow(castle_manager).to receive(:can_castle?).and_return(true)
          end

          it 'returns an array with G8' do
            expect(castle_move.generate_moves).to contain_exactly('G8')
          end
        end

        context 'when castling is not possible' do
          context 'when F8 is occupied' do
            before do
              allow(board).to receive(:access_square).with('F8').and_return(occupied_square)
              allow(castle_manager).to receive(:can_castle?).and_return(true)
            end

            it 'returns an empty array' do
              expect(castle_move.generate_moves).to be_empty
            end
          end

          context 'when E8 is under attack' do
            before do
              allow(board).to receive(:square_under_attack_from_color?).with(opposing_color, 'E8').and_return(true)
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
end
