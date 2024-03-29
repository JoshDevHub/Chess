# frozen_string_literal: true

RSpec.describe Queen do
  describe '#move_list' do
    subject(:queen) { described_class.new(color: 'white', position: square) }

    let(:board) { instance_double(Board) }
    let(:diagonal_move_instance) { instance_double(DiagonalLineMove) }
    let(:cardinal_move_instance) { instance_double(CardinalLineMove) }
    let(:square) { 'D1' }

    before do
      allow(DiagonalLineMove).to receive(:new).and_return(diagonal_move_instance)
      allow(diagonal_move_instance).to receive(:generate_moves).and_return([])

      allow(CardinalLineMove).to receive(:new).and_return(cardinal_move_instance)
      allow(cardinal_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of DiagonalLineMove' do
      queen.move_list(board)
      expect(DiagonalLineMove).to have_received(:new)
    end

    it 'sends #generate_moves to the DiagonalLineMove instance' do
      queen.move_list(board)
      expect(diagonal_move_instance).to have_received(:generate_moves)
    end

    it 'instantiates an instance of CardinalLineMove' do
      queen.move_list(board)
      expect(CardinalLineMove).to have_received(:new)
    end

    it 'sends #generate_moves to the CardinalLineMove instance' do
      queen.move_list(board)
      expect(cardinal_move_instance).to have_received(:generate_moves)
    end
  end

  describe '#to_fen' do
    subject(:queen) { described_class.new(color: color, position: 'E4') }

    context 'when the queen is white' do
      let(:color) { 'white' }

      it "returns the string 'Q'" do
        expected_string = 'Q'
        expect(queen.to_fen).to eq(expected_string)
      end
    end

    context 'when the queen is black' do
      let(:color) { 'black' }

      it "returns the string 'q'" do
        expected_string = 'q'
        expect(queen.to_fen).to eq(expected_string)
      end
    end
  end
end
