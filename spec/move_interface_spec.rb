# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/board'
require_relative '../lib/display'
require_relative '../lib/player'
require_relative '../lib/move_interface'
require_relative '../lib/move_interfaces/move_list_interface'
require_relative '../lib/move_interfaces/move_inline_interface'

describe MoveInterface do
  describe '#self.for_input' do
    subject(:move_interface) { described_class }
    let(:board) { instance_double(Board) }
    let(:player) { instance_double(Player) }
    let(:display) { instance_double(Display) }
    context 'when the given input has a size of 2' do
      let(:input) { 'E1' }
      let(:arguments) do
        {
          board: board,
          active_player: player,
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
          active_player: player,
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
          active_player: player,
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
          active_player: player,
          display: display,
          user_input: input
        }
      end
      it 'returns an instance of MoveInlineInterface' do
        expect(move_interface.for_input(**arguments)).to be_a(MoveInterface)
      end
    end
  end
end
