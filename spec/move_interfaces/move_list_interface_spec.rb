# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/display'
require_relative '../../lib/move_interface'
require_relative '../../lib/move_interfaces/move_list_interface'

describe MoveListInterface do
  describe '#move_selection' do
    let(:board) { instance_double(Board) }
    let(:active_color) { 'white' }
    let(:display) { double(Display) }
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
    subject(:move_list_interface) { described_class.new(**interface_arguments) }
    context 'when the user input is invalid' do
      let(:user_input) { 'E2' }
      before do
        allow(move_list_interface).to receive(:valid_origin?).with(user_input).and_return(false)
      end
      it 'returns nil' do
        expect(move_list_interface.move_selection).to be(nil)
      end
    end

    context 'when the target input is valid immediately' do
      let(:user_input) { 'E2' }
      let(:user_target) { 'E4' }
      let(:target_list) { %w[E3 E4] }
      before do
        allow(move_list_interface).to receive(:valid_origin?).with(user_input).and_return(true)
        allow(board).to receive(:move_list_from_origin).and_return(target_list)
        allow(display).to receive(:move_choice_prompt)
        allow(display).to receive(:input_error_message)
        allow(move_list_interface).to receive(:gets).and_return('E4')
      end
      it 'sends #move_list_from_origin to board with user_input and castle_manager' do
        expect(board).to receive(:move_list_from_origin).with(user_input, castle_manager)
        move_list_interface.move_selection
      end

      it 'sends #move_choice_prompt to display' do
        expect(display).to receive(:move_choice_prompt)
        move_list_interface.move_selection
      end

      it 'returns a hash with the key: origin set to user_input' do
        returned_hash = move_list_interface.move_selection
        expect(returned_hash[:origin]).to eq(user_input)
      end

      it 'returns a hash with the key: target set to user_target' do
        returned_hash = move_list_interface.move_selection
        expect(returned_hash[:target]).to eq(user_target)
      end
    end

    context "when the user inputs 'back'" do
      let(:user_input) { 'E2' }
      let(:user_target) { 'back' }
      let(:target_list) { %w[E3 E4] }
      before do
        allow(move_list_interface).to receive(:valid_origin?).with(user_input).and_return(true)
        allow(board).to receive(:move_list_from_origin).and_return(target_list)
        allow(display).to receive(:move_choice_prompt)
        allow(move_list_interface).to receive(:gets).and_return('back')
      end
      it 'sends #print to self with ansi sequence to delete 4 lines' do
        expected_ansi_code = "\r#{"\e[A\e" * 4}\e[J"
        expect(move_list_interface).to receive(:print).with(expected_ansi_code)
        move_list_interface.move_selection
      end
    end

    context 'when the target input is invalid once and then valid' do
      let(:user_input) { 'E2' }
      let(:user_target) { 'E4' }
      let(:target_list) { %w[E3 E4] }
      let(:bad_input) { 'D4' }
      before do
        allow(move_list_interface).to receive(:valid_origin?).with(user_input).and_return(true)
        allow(board).to receive(:move_list_from_origin).and_return(target_list)
        allow(display).to receive(:move_choice_prompt)
        allow(display).to receive(:input_error_message)
        allow(move_list_interface).to receive(:gets).and_return('D4', 'E4')
      end
      it 'sends #move_list_from_origin to board with user_input and castle_manager' do
        expect(board).to receive(:move_list_from_origin).with(user_input, castle_manager)
        move_list_interface.move_selection
      end

      it 'sends #move_choice_prompt to display twice' do
        expect(display).to receive(:move_choice_prompt).twice
        move_list_interface.move_selection
      end

      it 'returns a hash with the key: origin set to user_input' do
        returned_hash = move_list_interface.move_selection
        expect(returned_hash[:origin]).to eq(user_input)
      end

      it 'returns a hash with the key: target set to user_target' do
        returned_hash = move_list_interface.move_selection
        expect(returned_hash[:target]).to eq(user_target)
      end
    end
  end
end
