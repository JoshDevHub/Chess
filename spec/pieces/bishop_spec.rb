# frozen_string_literal: true

RSpec.describe Bishop do
  describe '#move_list' do
    subject(:bishop) { described_class.new(color: 'white', position: square) }
    let(:board) { instance_double(Board) }
    let(:diagonal_move_instance) { instance_double(DiagonalLineMove) }
    let(:square) { 'C8' }
    before do
      allow(DiagonalLineMove).to receive(:new).and_return(diagonal_move_instance)
      allow(diagonal_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of DiagonalLineMove' do
      expect(DiagonalLineMove).to receive(:new).and_return(diagonal_move_instance)
      bishop.move_list(board)
    end

    it 'sends #generate_moves to the DiagonalLineMove instance' do
      expect(diagonal_move_instance).to receive(:generate_moves)
      bishop.move_list(board)
    end
  end

  describe '#to_fen' do
    let(:square) { 'A1' }
    context 'when the bishop is white' do
      subject(:bishop) { described_class.new(color: 'white', position: square) }
      it "returns the string 'B'" do
        expected_string = 'B'
        expect(bishop.to_fen).to eq(expected_string)
      end
    end

    context 'when the bishop is black' do
      subject(:bishop) { described_class.new(color: 'black', position: square) }
      it "returns the string 'b'" do
        expected_string = 'b'
        expect(bishop.to_fen).to eq(expected_string)
      end
    end
  end
end
