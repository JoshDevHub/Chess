# frozen_string_literal: true

RSpec.describe MoveListInterface do
  describe '#move_selection' do
    subject(:move_list_interface) { described_class.new(**interface_arguments) }

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

    context 'when the user input is invalid' do
      let(:user_input) { 'E2' }

      before do
        allow(move_list_interface).to receive(:valid_origin?).with(user_input).and_return(false)
      end

      it 'returns nil' do
        expect(move_list_interface.move_selection).to be_nil
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

      it 'sends #move_choice_prompt to display with board and move_list' do
        expect(display).to receive(:move_choice_prompt).with(board, target_list)
        move_list_interface.move_selection
      end

      it 'calls #gets once' do
        expect(move_list_interface).to receive(:gets).once
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
        allow(display).to receive(:delete_display_lines)
        allow(move_list_interface).to receive(:gets).and_return('back')
      end

      it 'returns nil' do
        expect(move_list_interface.move_selection).to be_nil
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

      it 'sends #move_choice_prompt to display with board and target_list' do
        expect(display).to receive(:move_choice_prompt).with(board, target_list)
        move_list_interface.move_selection
      end

      it 'calls #gets twice' do
        expect(move_list_interface).to receive(:gets).twice
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
