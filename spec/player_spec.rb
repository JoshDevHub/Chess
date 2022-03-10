# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#create_user_name' do
    let(:color) { 'white' }
    subject(:player_one) { described_class.new(color: color) }
    context 'when the user gives the name Josh' do
      before do
        expected_name = 'Josh'
        allow(player_one).to receive(:puts)
        allow(player_one).to receive(:gets).and_return(expected_name)
      end
      it 'changes @name to Josh' do
        expected_name = 'Josh'
        expect { player_one.create_user_name }.to change { player_one.instance_variable_get(:@name) }
          .to(expected_name)
      end
    end
    context 'when the user gives the name Magnus Carlsen' do
      before do
        expected_name = 'Magnus Carlsen'
        allow(player_one).to receive(:puts)
        allow(player_one).to receive(:gets).and_return(expected_name)
      end
      it 'changes @name to Magnus Carlsen' do
        expected_name = 'Magnus Carlsen'
        expect { player_one.create_user_name }.to change { player_one.instance_variable_get(:@name) }
          .to(expected_name)
      end
    end
  end
end
