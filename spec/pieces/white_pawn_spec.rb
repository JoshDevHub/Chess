# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/white_pawn'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_up_capture'
require_relative '../../lib/moves/double_up_move'
require_relative '../../lib/moves/one_up_move'

describe WhitePawn do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:white_pawn) { described_class.new(color: 'white', position: square) }
  describe '#move_list' do
    let(:double_up_instance) { instance_double(DoubleUpMove) }
    let(:diagonal_capture) { instance_double(DiagonalUpCapture) }
    let(:one_up) { instance_double(OneUpMove) }
    context 'when the piece is off the 2nd rank' do
      let(:square) { 'B5' }
      before do
        allow(OneUpMove).to receive(:new).and_return(one_up)
        allow(DiagonalUpCapture).to receive(:new).and_return(diagonal_capture)

        allow(one_up).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of OneUpMove' do
        expect(OneUpMove).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the OneUpMove instance' do
        expect(one_up).to receive(:generate_moves)
        white_pawn.move_list(board)
      end

      it 'instantiates an instance of DiagonalUpCapture' do
        expect(DiagonalUpCapture).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the DiagonalUpCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        white_pawn.move_list(board)
      end

      it 'does not instantiate an instance of DoubleUpMove' do
        expect(DoubleUpMove).not_to receive(:new)
        white_pawn.move_list(board)
      end
    end

    context 'when the piece is on the 2nd rank' do
      let(:square) { 'E2' }
      before do
        allow(OneUpMove).to receive(:new).and_return(one_up)
        allow(DiagonalUpCapture).to receive(:new).and_return(diagonal_capture)
        allow(DoubleUpMove).to receive(:new).and_return(double_up_instance)

        allow(one_up).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
        allow(double_up_instance).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of OneUpMove' do
        expect(OneUpMove).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the OneUpMove instance' do
        expect(one_up).to receive(:generate_moves)
        white_pawn.move_list(board)
      end

      it 'instantiates an instance of DiagonalUpCapture' do
        expect(DiagonalUpCapture).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the DiagonalUpCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        white_pawn.move_list(board)
      end

      it 'instantiates an instance of DoubleUpMove' do
        expect(DoubleUpMove).to receive(:new)
        white_pawn.move_list(board)
      end

      it 'sends #generate_moves to the DoubleUpMove instance' do
        expect(double_up_instance).to receive(:generate_moves)
        white_pawn.move_list(board)
      end
    end
  end
end
