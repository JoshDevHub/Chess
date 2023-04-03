# frozen_string_literal: true

RSpec.describe Knight do
  describe '#move_list' do
    subject(:knight) { described_class.new(color: 'black', position: square) }

    let(:board) { instance_double(Board) }
    let(:knight_move_instance) { instance_double(KnightMoves) }
    let(:square) { 'B1' }

    before do
      allow(KnightMoves).to receive(:new).and_return(knight_move_instance)
      allow(knight_move_instance).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of KnightMoves' do
      knight.move_list(board)
      expect(KnightMoves).to have_received(:new)
    end

    it 'sends #generate_moves to the KnightMoves instance' do
      knight.move_list(board)
      expect(knight_move_instance).to have_received(:generate_moves)
    end
  end

  describe '#to_fen' do
    subject(:knight) { described_class.new(color: color, position: 'E4') }

    context 'when the knight is white' do
      let(:color) { 'white' }

      it "returns the string 'N'" do
        expected_string = 'N'
        expect(knight.to_fen).to eq(expected_string)
      end
    end

    context 'when the knight is black' do
      let(:color) { 'black' }

      it "returns the string 'n'" do
        expected_string = 'n'
        expect(knight.to_fen).to eq(expected_string)
      end
    end
  end
end
