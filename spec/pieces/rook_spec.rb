# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/rook'
require_relative '../../lib/move'
require_relative '../../lib/moves/cardinal_line_move'
require_relative '../../lib/castle_manager'

describe Rook do
  subject(:rook) { described_class.new(color: 'black', position: square) }
  let(:board) { instance_double(Board) }
  describe '#move_list' do
    let(:cardinal_move_instance) { instance_double(CardinalLineMove) }
    let(:square) { 'A8' }
    before do
      allow(CardinalLineMove).to receive(:new).and_return(cardinal_move_instance)
      allow(cardinal_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of CardinalLineMove' do
      expect(CardinalLineMove).to receive(:new)
      rook.move_list(board)
    end

    it 'sends #generate_moves to the CardinalMoves instance' do
      expect(cardinal_move_instance).to receive(:generate_moves)
      rook.move_list(board)
    end
  end

  describe '#involved_in_castling?' do
    subject(:rook) { described_class.new(color: color, position: position) }
    context 'when the rook is white' do
      let(:color) { 'white' }
      context 'when the rook is involved in castling' do
        context 'when the rook is on A1' do
          let(:position) { 'A1' }
          it 'returns true' do
            expect(rook.involved_in_castling?).to be(true)
          end
        end

        context 'when the rook is on H1' do
          let(:position) { 'H1' }
          it 'returns true' do
            expect(rook.involved_in_castling?).to be(true)
          end
        end
      end

      context 'when the rook is not involved in castling' do
        context 'when the rook is on A2' do
          let(:position) { 'A2' }
          it 'returns false' do
            expect(rook.involved_in_castling?).to be(false)
          end
        end

        context 'when the rook is on A8' do
          let(:position) { 'A8' }
          it 'returns false' do
            expect(rook.involved_in_castling?).to be(false)
          end
        end
      end
    end

    context 'when the rook is black' do
      let(:color) { 'black' }
      context 'when the rook is involved in castling' do
        context 'when the rook is on A8' do
          let(:position) { 'A8' }
          it 'returns true' do
            expect(rook.involved_in_castling?).to be(true)
          end
        end

        context 'when the rook is on H8' do
          let(:position) { 'H8' }
          it 'returns true' do
            expect(rook.involved_in_castling?).to be(true)
          end
        end
      end

      context 'when the rook is not involved in castling' do
        context 'when the rook is on H1' do
          let(:position) { 'H1' }
          it 'returns false' do
            expect(rook.involved_in_castling?).to be(false)
          end
        end
      end
    end
  end

  describe '#disable_castle_rights' do
    let(:castle_manager) { instance_double(CastleManager) }
    subject(:rook) { described_class.new(color: color, position: position) }
    context 'when the rook is white' do
      let(:color) { 'white' }
      context 'when the rook is on the A file' do
        let(:position) { 'A1' }
        it 'sends #remove_castle_option to the given castle_manager with :queen and color' do
          side = :queen
          expect(castle_manager).to receive(:remove_castle_option).with(color, side)
          rook.disable_castle_rights(castle_manager)
        end
      end
      context 'when the rook is on the H file' do
        let(:position) { 'H1' }
        it 'send #remove_castle_option to the given castle_manager with :king and color' do
          side = :king
          expect(castle_manager).to receive(:remove_castle_option).with(color, side)
          rook.disable_castle_rights(castle_manager)
        end
      end

      context 'when the rook is on the A file' do
        let(:position) { 'A1' }
        it 'send #remove_castle_option to the given castle_manager with :king and color' do
          side = :queen
          expect(castle_manager).to receive(:remove_castle_option).with(color, side)
          rook.disable_castle_rights(castle_manager)
        end
      end

      context 'when the rook is not on the A or H files' do
        let(:position) { 'B1' }
        it 'returns nil' do
          expect(rook.disable_castle_rights(castle_manager)).to be(nil)
        end

        it 'does not send #remove_castle_option to the castle_manager' do
          expect(castle_manager).to_not receive(:remove_castle_option)
        end
      end
    end

    context 'when the rook is black' do
      let(:color) { 'black' }
      context 'when the rook is on the A file' do
        let(:position) { 'A8' }
        it 'sends #remove_castle_option to the given castle_manager with :queen and color' do
          side = :queen
          expect(castle_manager).to receive(:remove_castle_option).with(color, side)
          rook.disable_castle_rights(castle_manager)
        end
      end
      context 'when the rook is on the H file' do
        let(:position) { 'H8' }
        it 'send #remove_castle_option to the given castle_manager with :king and color' do
          side = :king
          expect(castle_manager).to receive(:remove_castle_option).with(color, side)
          rook.disable_castle_rights(castle_manager)
        end
      end

      context 'when the rook is not on the A or H files' do
        let(:position) { 'C8' }
        it 'returns nil' do
          expect(rook.disable_castle_rights(castle_manager)).to be(nil)
        end

        it 'does not send #remove_castle_option to the castle_manager' do
          expect(castle_manager).to_not receive(:remove_castle_option)
        end
      end
    end
  end

  describe '#to_fen' do
    subject(:rook) { described_class.new(color: color, position: 'E4') }
    context 'when the rook is white' do
      let(:color) { 'white' }
      it "returns the string 'R'" do
        expected_string = 'R'
        expect(rook.to_fen).to eq(expected_string)
      end
    end

    context 'when the rook is black' do
      let(:color) { 'black' }
      it "returns the string 'r'" do
        expected_string = 'r'
        expect(rook.to_fen).to eq(expected_string)
      end
    end
  end
end
