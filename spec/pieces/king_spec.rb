# frozen_string_literal: true

require_relative '../../lib/coordinate'
require_relative '../../lib/board'
require_relative '../../lib/piece'
require_relative '../../lib/pieces/king'
require_relative '../../lib/move'
require_relative '../../lib/moves/king_move'
require_relative '../../lib/moves/king_side_castle'
require_relative '../../lib/moves/queen_side_castle'

describe King do
  subject(:king) { described_class.new(color: 'white', position: square) }
  let(:board) { instance_double(Board) }
  let(:king_move_instance) { instance_double(KingMove) }
  let(:king_castle_move) { instance_double(KingSideCastle) }
  let(:queen_castle_move) { instance_double(QueenSideCastle) }
  describe '#move_list' do
    let(:square) { 'E8' }
    before do
      allow(KingMove).to receive(:new).and_return(king_move_instance)
      allow(KingSideCastle).to receive(:new).and_return(king_castle_move)
      allow(QueenSideCastle).to receive(:new).and_return(queen_castle_move)
      allow(king_move_instance).to receive(:generate_moves).and_return([])
      allow(king_castle_move).to receive(:generate_moves).and_return([])
      allow(queen_castle_move).to receive(:generate_moves).and_return([])
    end

    it 'instantiates an instance of KingMove' do
      expect(KingMove).to receive(:new)
      king.move_list(board)
    end

    it 'sends #generate_moves to the KingMove instance' do
      expect(king_move_instance).to receive(:generate_moves)
      king.move_list(board)
    end

    it 'instantiates an instance of WhiteKingSideCastle' do
      expect(KingSideCastle).to receive(:new)
      king.move_list(board)
    end

    it 'sends #generate_moves to the WhiteKingSideCastle instance' do
      expect(king_castle_move).to receive(:generate_moves)
      king.move_list(board)
    end

    it 'instantiates an instance of WhiteQueenSideCastle' do
      expect(QueenSideCastle).to receive(:new)
      king.move_list(board)
    end

    it 'sends #generate_moves to the WhiteQueenSideCastle instance' do
      expect(queen_castle_move).to receive(:generate_moves)
      king.move_list(board)
    end
  end
end
