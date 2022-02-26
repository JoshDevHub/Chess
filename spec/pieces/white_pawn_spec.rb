# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/white_pawn'
require_relative '../../lib/move'
require_relative '../../lib/moves/white_pawn_capture'
require_relative '../../lib/moves/white_pawn_double_advance'
require_relative '../../lib/moves/white_pawn_advance'

describe WhitePawn do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:white_pawn) { described_class.new(color: 'white', position: square) }
  describe '#move_list' do
    let(:double_up_instance) { instance_double(WhitePawnDoubleAdvance) }
    let(:diagonal_capture) { instance_double(WhitePawnCapture) }
    let(:one_up) { instance_double(WhitePawnAdvance) }
    context 'when the piece is off the 2nd rank' do
      let(:square) { 'B5' }
      before do
        allow(WhitePawnAdvance).to receive(:new).and_return(one_up)
        allow(WhitePawnCapture).to receive(:new).and_return(diagonal_capture)

        allow(one_up).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of WhitePawnAdvance' do
        expect(WhitePawnAdvance).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the WhitePawnAdvance instance' do
        expect(one_up).to receive(:generate_moves)
        white_pawn.move_list(board)
      end

      it 'instantiates an instance of WhitePawnCapture' do
        expect(WhitePawnCapture).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the WhitePawnCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        white_pawn.move_list(board)
      end

      it 'does not instantiate an instance of WhitePawnDoubleAdvance' do
        expect(WhitePawnDoubleAdvance).not_to receive(:new)
        white_pawn.move_list(board)
      end
    end

    context 'when the piece is on the 2nd rank' do
      let(:square) { 'E2' }
      before do
        allow(WhitePawnAdvance).to receive(:new).and_return(one_up)
        allow(WhitePawnCapture).to receive(:new).and_return(diagonal_capture)
        allow(WhitePawnDoubleAdvance).to receive(:new).and_return(double_up_instance)

        allow(one_up).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
        allow(double_up_instance).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of WhitePawnAdvance' do
        expect(WhitePawnAdvance).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the WhitePawnAdvance instance' do
        expect(one_up).to receive(:generate_moves)
        white_pawn.move_list(board)
      end

      it 'instantiates an instance of WhitePawnCapture' do
        expect(WhitePawnCapture).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the WhitePawnCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        white_pawn.move_list(board)
      end

      it 'instantiates an instance of WhitePawnDoubleAdvance' do
        expect(WhitePawnDoubleAdvance).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the WhitePawnDoubleAdvance instance' do
        expect(double_up_instance).to receive(:generate_moves)
        white_pawn.move_list(board)
      end
    end
  end

  describe '#define_en_passant_square' do
    context 'when the passed in move indicates a normal pawn move' do
      let(:square) { 'F5' }
      let(:target) { 'F6' }
      it 'returns nil' do
        expect(white_pawn.define_en_passant_square(target)).to be(nil)
      end
    end

    context 'when the passed in move indicates a capture move' do
      let(:square) { 'E2' }
      let(:target) { 'D3' }
      it 'returns nil' do
        expect(white_pawn.define_en_passant_square(target)).to be(nil)
      end
    end

    context 'when the passed in move indicates a double move' do
      let(:square) { 'B2' }
      let(:target) { 'B4' }
      let(:en_passant) { 'B3' }
      it 'returns the position above the origin' do
        expect(white_pawn.define_en_passant_square(target)).to eq(en_passant)
      end
    end
  end
end
