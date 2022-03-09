# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/square'
require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/display'
require_relative '../lib/move_interface'
require_relative '../lib/move_interfaces/move_list_interface'
require_relative '../lib/move_interfaces/move_inline_interface'

describe MoveInterface do
  let(:board) { instance_double(Board) }
  let(:display) { instance_double(Display) }
  let(:active_color) { 'white' }
  describe '#self.for_input' do
    subject(:move_interface) { described_class }
    context 'when the given input has a size of 2' do
      let(:input) { 'E1' }
      let(:arguments) do
        {
          board: board,
          active_color: active_color,
          display: display,
          user_input: input
        }
      end
      it 'returns an instance of MoveListInterface' do
        expect(move_interface.for_input(**arguments)).to be_a(MoveListInterface)
      end
    end

    context 'when the given input has a size of four' do
      let(:input) { 'E2E4' }
      let(:arguments) do
        {
          board: board,
          active_color: active_color,
          display: display,
          user_input: input
        }
      end
      it 'returns an instance of MoveInlineInterface' do
        expect(move_interface.for_input(**arguments)).to be_a(MoveInlineInterface)
      end
    end

    context 'when the given input has a size of 5' do
      let(:input) { 'E2E45' }
      let(:arguments) do
        {
          board: board,
          active_color: active_color,
          display: display,
          user_input: input
        }
      end
      it 'returns an instance of MoveInlineInterface' do
        expect(move_interface.for_input(**arguments)).to be_a(MoveInterface)
      end
    end

    context 'when the given input has a size of 1' do
      let(:input) { 'E' }
      let(:arguments) do
        {
          board: board,
          active_color: active_color,
          display: display,
          user_input: input
        }
      end
      it 'returns an instance of MoveInlineInterface' do
        expect(move_interface.for_input(**arguments)).to be_a(MoveInterface)
      end
    end
  end

  describe '#move_selection' do
    subject(:default_move_interface) { described_class.new(**arguments) }
    let(:arguments) do
      {
        board: board,
        active_color: active_color,
        display: display,
        user_input: 'ABC'
      }
    end
    it 'returns nil' do
      expect(default_move_interface.move_selection).to be(nil)
    end
  end

  describe '#valid_origin' do
    subject(:move_interface) { described_class.new(**arguments) }
    let(:arguments) do
      {
        board: board,
        active_color: active_color,
        display: display,
        user_input: 'E2E4'
      }
    end
    context 'when the origin is valid' do
      let(:color) { 'white' }
      let(:e2_square) { instance_double(Square, piece_color: color, unoccupied?: false) }
      let(:piece) { instance_double(Piece, move_list: move_list) }
      let(:move_list) { %w[E3 E4] }
      before do
        allow(board).to receive(:access_square).with('E2').and_return(e2_square)
        allow(board).to receive(:self_check_filter).with(piece, move_list).and_return(move_list)
        allow(display).to receive(:input_error_message)
        allow(e2_square).to receive(:piece).and_return(piece)
      end

      it 'returns true' do
        origin = 'E2'
        expect(move_interface.valid_origin?(origin)).to be(true)
      end
    end

    context 'when the origin is invalid' do
      context 'when the square does not exist in the game' do
        let(:origin) { 'F@' }
        before do
          allow(display).to receive(:input_error_message)
        end
        it 'returns falsey' do
          expect(move_interface.valid_origin?(origin)).to be_falsey
        end

        it 'sends display #input_error_message with :invalid_square' do
          expect(display).to receive(:input_error_message).with(:invalid_square)
          move_interface.valid_origin?(origin)
        end
      end

      context 'when the origin square is empty' do
        let(:origin) { 'E2' }
        let(:e2_square) { instance_double(Square) }
        before do
          allow(display).to receive(:input_error_message)
          allow(board).to receive(:access_square).with(origin).and_return(e2_square)
          allow(e2_square).to receive(:unoccupied?).and_return(true)
        end
        it 'returns falsey' do
          expect(move_interface.valid_origin?(origin)).to be_falsey
        end

        it 'sends display #input_error_message with :empty_square' do
          expect(display).to receive(:input_error_message).with(:empty_square)
          move_interface.valid_origin?(origin)
        end
      end

      context 'when the piece color of the origin square does not match player color' do
        let(:origin) { 'E2' }
        let(:opponent_color) { 'black' }
        let(:e2_square) { instance_double(Square, unoccupied?: false) }
        before do
          allow(display).to receive(:input_error_message)
          allow(board).to receive(:access_square).with(origin).and_return(e2_square)
          allow(e2_square).to receive(:piece_color).and_return(opponent_color)
        end
        it 'returns falsey' do
          expect(move_interface.valid_origin?(origin)).to be_falsey
        end

        it 'sends display #input_error_message with :wrong_color' do
          expect(display).to receive(:input_error_message).with(:wrong_color)
          move_interface.valid_origin?(origin)
        end
      end

      context 'when the piece has no legal moves' do
        let(:origin) { 'E2' }
        let(:e2_square) { instance_double(Square, unoccupied?: false, piece_color: 'white') }
        let(:piece) { instance_double(Piece) }
        let(:move_list) { [] }
        before do
          allow(display).to receive(:input_error_message)
          allow(board).to receive(:access_square).with(origin).and_return(e2_square)
          allow(e2_square).to receive(:piece).and_return(piece)
          allow(piece).to receive(:move_list).and_return(move_list)
          allow(board).to receive(:self_check_filter).with(piece, move_list).and_return(move_list)
        end

        it 'returns falsey' do
          expect(move_interface.valid_origin?(origin)).to be_falsey
        end

        it 'sends display #input_error_message with :no_moves' do
          expect(display).to receive(:input_error_message).with(:no_moves)
          move_interface.valid_origin?(origin)
        end
      end
    end
  end
end
