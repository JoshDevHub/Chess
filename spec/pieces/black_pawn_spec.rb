# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/black_pawn'
require_relative '../../lib/move'
require_relative '../../lib/moves/diagonal_down_capture'
require_relative '../../lib/moves/double_down_move'
require_relative '../../lib/moves/one_down_move'

describe BlackPawn do
  let(:board) { instance_double(Board, square_empty?: true) }
  subject(:black_pawn) { described_class.new(color: 'black', position: square) }
  describe '#move_list' do
    let(:double_down_instance) { instance_double(DoubleDownMove) }
    let(:diagonal_capture) { instance_double(DiagonalDownCapture) }
    let(:one_down) { instance_double(OneDownMove) }
    context 'when the piece is off the 7th rank' do
      let(:square) { 'B5' }
      before do
        allow(OneDownMove).to receive(:new).and_return(one_down)
        allow(DiagonalDownCapture).to receive(:new).and_return(diagonal_capture)

        allow(one_down).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of OneDownMove' do
        expect(OneDownMove).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the OneDownMove instance' do
        expect(one_down).to receive(:generate_moves)
        black_pawn.move_list(board)
      end

      it 'instantiates an instance of DiagonalDownCapture' do
        expect(DiagonalDownCapture).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the DiagonalDownCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        black_pawn.move_list(board)
      end

      it 'does not instantiate an instance of DoubleDownMove' do
        expect(DoubleDownMove).not_to receive(:new)
        black_pawn.move_list(board)
      end
    end

    context 'when the piece is on the 7th rank' do
      let(:square) { 'E7' }
      before do
        allow(OneDownMove).to receive(:new).and_return(one_down)
        allow(DiagonalDownCapture).to receive(:new).and_return(diagonal_capture)
        allow(DoubleDownMove).to receive(:new).and_return(double_down_instance)

        allow(one_down).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
        allow(double_down_instance).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of OneDownMove' do
        expect(OneDownMove).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the OneDownMove instance' do
        expect(one_down).to receive(:generate_moves)
        black_pawn.move_list(board)
      end

      it 'instantiates an instance of DiagonalDownCapture' do
        expect(DiagonalDownCapture).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the DiagonalDownCapture instance' do
        expect(diagonal_capture).to receive(:generate_moves).and_return([])
        black_pawn.move_list(board)
      end

      it 'instantiates an instance of DoubleDownMove' do
        expect(DoubleDownMove).to receive(:new)
        black_pawn.move_list(board)
      end

      it 'sends #generate_moves to the DoubleDownMove instance' do
        expect(double_down_instance).to receive(:generate_moves)
        black_pawn.move_list(board)
      end
    end
  end
end
