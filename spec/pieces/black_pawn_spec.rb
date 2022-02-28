# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/black_pawn'
require_relative '../../lib/move'
require_relative '../../lib/moves/black_pawn_capture'
require_relative '../../lib/moves/black_pawn_double_advance'
require_relative '../../lib/moves/black_pawn_advance'

describe BlackPawn do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:black_pawn) { described_class.new(color: 'black', position: square) }
  describe '#move_list' do
    let(:double_down_instance) { instance_double(BlackPawnDoubleAdvance) }
    let(:diagonal_capture) { instance_double(BlackPawnCapture) }
    let(:one_down) { instance_double(BlackPawnAdvance) }
    context 'when the piece is off the 7th rank' do
      let(:square) { 'B5' }
      before do
        allow(BlackPawnAdvance).to receive(:new).and_return(one_down)
        allow(BlackPawnCapture).to receive(:new).and_return(diagonal_capture)

        allow(one_down).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of BlackPawnAdvance' do
        expect(BlackPawnAdvance).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the BlackPawnAdvance instance' do
        expect(one_down).to receive(:generate_moves)
        black_pawn.move_list(board)
      end

      it 'instantiates an instance of BlackPawnCapture' do
        expect(BlackPawnCapture).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the BlackPawnCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        black_pawn.move_list(board)
      end

      it 'does not instantiate an instance of BlackPawnDoubleAdvance' do
        expect(BlackPawnDoubleAdvance).not_to receive(:new)
        black_pawn.move_list(board)
      end
    end

    context 'when the piece is on the 7th rank' do
      let(:square) { 'E7' }
      before do
        allow(BlackPawnAdvance).to receive(:new).and_return(one_down)
        allow(BlackPawnCapture).to receive(:new).and_return(diagonal_capture)
        allow(BlackPawnDoubleAdvance).to receive(:new).and_return(double_down_instance)

        allow(one_down).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
        allow(double_down_instance).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of BlackPawnAdvance' do
        expect(BlackPawnAdvance).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the BlackPawnAdvance instance' do
        expect(one_down).to receive(:generate_moves)
        black_pawn.move_list(board)
      end

      it 'instantiates an instance of BlackPawnCapture' do
        expect(BlackPawnCapture).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the BlackPawnCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        black_pawn.move_list(board)
      end

      it 'instantiates an instance of BlackPawnDoubleAdvance' do
        expect(BlackPawnDoubleAdvance).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the BlackPawnDoubleAdvance instance' do
        expect(double_down_instance).to receive(:generate_moves)
        black_pawn.move_list(board)
      end
    end
  end

  describe '#define_en_passant_square' do
    context 'when the passed in move indicates a normal pawn move' do
      let(:square) { 'F7' }
      let(:target) { 'F6' }
      it 'returns nil' do
        expect(black_pawn.define_en_passant_square(target)).to be(nil)
      end
    end

    context 'when the passed in move indicates a capture move' do
      let(:square) { 'E7' }
      let(:target) { 'D6' }
      it 'returns nil' do
        expect(black_pawn.define_en_passant_square(target)).to be(nil)
      end
    end

    context 'when the passed in move indicates a double move' do
      let(:square) { 'B7' }
      let(:target) { 'B5' }
      let(:en_passant) { 'B6' }
      it 'returns the position above the origin' do
        expect(black_pawn.define_en_passant_square(target)).to eq(en_passant)
      end
    end
  end

  describe '#capture_en_passant?' do
    let(:square) { 'B4' }
    context 'when the given square is not an en passant square for white' do
      context 'when the given square is nil' do
        let(:given_square) { nil }
        it 'returns nil or false' do
          expect(black_pawn.capture_en_passant?(given_square)).to be_falsey
        end
      end

      context 'when the square is not nil' do
        let(:given_square) { 'B2' }
        it 'returns nil or false' do
          expect(black_pawn.capture_en_passant?(given_square)).to be_falsey
        end

        let(:given_square) { 'B1' }
        it 'returns nil or false' do
          expect(black_pawn.capture_en_passant?(given_square)).to be_falsey
        end
      end
    end

    context 'when the given square is an en passant square for white' do
      let(:given_square) { 'C3' }
      it 'returns true' do
        expect(black_pawn.capture_en_passant?(given_square)).to be(true)
      end

      let(:given_square) { 'A3' }
      it 'returns true' do
        expect(black_pawn.capture_en_passant?(given_square)).to be(true)
      end
    end
  end

  describe '#can_promote?' do
    context 'when the pawn cannot promote' do
      context 'when the black pawn is on C4' do
        let(:square) { 'C4' }
        it 'returns false' do
          expect(black_pawn.can_promote?).to be(false)
        end
      end

      context 'when the pawn is on F2' do
        let(:square) { 'F2' }
        it 'returns false' do
          expect(black_pawn.can_promote?).to be(false)
        end
      end
    end

    context 'when the pawn can promote' do
      context 'when the white pawn is on C1' do
        let(:square) { 'C1' }
        it 'returns true' do
          expect(black_pawn.can_promote?).to be(true)
        end
      end

      context 'when teh pawn is on F1' do
        let(:square) { 'F1' }
        it 'returns true' do
          expect(black_pawn.can_promote?).to be(true)
        end
      end
    end
  end
end
