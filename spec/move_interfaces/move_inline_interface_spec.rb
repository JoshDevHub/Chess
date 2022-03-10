# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/move_interface'
require_relative '../../lib/move_interfaces/move_inline_interface'

describe MoveInlineInterface do
  describe '#move_selection' do
    let(:board) { instance_double(Board) }
    let(:active_color) { 'white' }
    let(:display) { double('display') }
    let(:castle_manager) { double('castle') }
    let(:interface_arguments) do
      {
        board: board,
        active_color: active_color,
        display: display,
        castle_manager: castle_manager,
        user_input: user_input
      }
    end
    subject(:move_inline_interface) { described_class.new(**interface_arguments) }
    context 'when the origin and targets are valid' do
      let(:user_input) { 'E2E4' }
      before do
        allow(move_inline_interface).to receive(:valid_origin?).and_return(true)
        allow(move_inline_interface).to receive(:valid_target?).and_return(true)
        allow(board).to receive(:move_list_from_origin)
      end
      it 'returns a hash with the origin key as the first two characters of user_input' do
        output_hash = move_inline_interface.move_selection
        expect(output_hash[:origin]).to eq(user_input[0..1])
      end

      it 'returns a hash with the target key as the last two characters of user_input' do
        output_hash = move_inline_interface.move_selection
        expect(output_hash[:target]).to eq(user_input[2..3])
      end

      it 'sends #move_list_from_origin message to board with origin and castle_manager' do
        origin = user_input[0..1]
        expect(board).to receive(:move_list_from_origin).with(origin, castle_manager)
        move_inline_interface.move_selection
      end
    end

    context 'when the origin is invalid' do
      let(:user_input) { 'E2E4' }
      before do
        allow(move_inline_interface).to receive(:valid_origin?).and_return(false)
      end

      it 'returns nil' do
        expect(move_inline_interface.move_selection).to be(nil)
      end
    end

    context 'when the target is invalid' do
      let(:user_input) { 'E2E4' }
      before do
        allow(move_inline_interface).to receive(:valid_origin?).and_return(true)
        allow(board).to receive(:move_list_from_origin)
        allow(move_inline_interface).to receive(:valid_target?).and_return(false)
      end

      it 'returns nil' do
        expect(move_inline_interface.move_selection).to be(nil)
      end

      it 'sends #move_list_from_origin to board with origin and castle_manager' do
        origin = user_input[0..1]
        expect(board).to receive(:move_list_from_origin).with(origin, castle_manager)
        move_inline_interface.move_selection
      end
    end
  end
end
