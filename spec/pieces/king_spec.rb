# frozen_string_literal: true

RSpec.describe King do
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
      king.move_list(board)
      expect(KingMove).to have_received(:new)
    end

    it 'sends #generate_moves to the KingMove instance' do
      king.move_list(board)
      expect(king_move_instance).to have_received(:generate_moves)
    end

    it 'instantiates an instance of WhiteKingSideCastle' do
      king.move_list(board)
      expect(KingSideCastle).to have_received(:new)
    end

    it 'sends #generate_moves to the WhiteKingSideCastle instance' do
      king.move_list(board)
      expect(king_castle_move).to have_received(:generate_moves)
    end

    it 'instantiates an instance of WhiteQueenSideCastle' do
      king.move_list(board)
      expect(QueenSideCastle).to have_received(:new)
    end

    it 'sends #generate_moves to the WhiteQueenSideCastle instance' do
      king.move_list(board)
      expect(queen_castle_move).to have_received(:generate_moves)
    end
  end

  describe '#involved_in_castling?' do
    subject(:king) { described_class.new(color: color, position: position) }

    context 'when the king is white' do
      let(:color) { 'white' }

      context 'when the king is on E1' do
        let(:position) { 'E1' }

        it 'returns true' do
          expect(king.involved_in_castling?).to be(true)
        end
      end

      context 'when the king is on E2' do
        let(:position) { 'E2' }

        it 'returns false' do
          expect(king.involved_in_castling?).to be(false)
        end
      end

      context 'when the king is on E8' do
        let(:position) { 'E8' }

        it 'returns false' do
          expect(king.involved_in_castling?).to be(false)
        end
      end

      context 'when the king is on D1' do
        let(:position) { 'D1' }

        it 'returns false' do
          expect(king.involved_in_castling?).to be(false)
        end
      end
    end

    context 'when the king is black' do
      let(:color) { 'black' }

      context 'when the king is on E8' do
        let(:position) { 'E8' }

        it 'returns true' do
          expect(king.involved_in_castling?).to be(true)
        end
      end

      context 'when the king is on E1' do
        let(:position) { 'E1' }

        it 'returns false' do
          expect(king.involved_in_castling?).to be(false)
        end
      end

      context 'when the king is on F8' do
        let(:position) { 'F8' }

        it 'returns false' do
          expect(king.involved_in_castling?).to be(false)
        end
      end
    end
  end

  describe '#castle_move?' do
    context 'when the king has a white color' do
      subject(:king) { described_class.new(color: 'white', position: position) }

      context 'when the move is a castle move' do
        let(:position) { 'E1' }

        context 'when the move is a king side castle' do
          let(:target) { 'G1' }

          it 'returns true' do
            expect(king.castle_move?(target)).to be(true)
          end
        end

        context 'when the move is a queen side castle' do
          let(:target) { 'C1' }

          it 'returns true' do
            expect(king.castle_move?(target)).to be(true)
          end
        end
      end

      context 'when the move is not a castle move' do
        context 'when the position is E1 but the target is not G1 or C1' do
          let(:position) { 'E1' }
          let(:target) { 'F1' }

          it 'returns false' do
            expect(king.castle_move?(target)).to be(false)
          end
        end

        context 'when the target is G1 or C1 but the position is not E1' do
          let(:position) { 'F1' }
          let(:target) { 'G1' }

          it 'returns false' do
            expect(king.castle_move?(target)).to be(false)
          end
        end
      end
    end

    context 'when the king has a black color' do
      subject(:black_king) { described_class.new(color: 'black', position: position) }

      context 'when the move is a castle move' do
        let(:position) { 'E8' }

        context 'when the move is a king side castle' do
          let(:target) { 'G8' }

          it 'returns true' do
            expect(black_king.castle_move?(target)).to be(true)
          end
        end

        context 'when the move is a queen side castle' do
          let(:target) { 'C8' }

          it 'returns true' do
            expect(black_king.castle_move?(target)).to be(true)
          end
        end
      end

      context 'when the move is not a castle move' do
        context 'when the position is E8 but the target is not G8 or C8' do
          let(:position) { 'E8' }
          let(:target) { 'D8' }

          it 'returns false' do
            expect(black_king.castle_move?(target)).to be(false)
          end
        end

        context 'when the target is G8 or C8 but the position is not E8' do
          let(:position) { 'B8' }
          let(:target) { 'C8' }

          it 'returns false' do
            expect(black_king.castle_move?(target)).to be(false)
          end
        end
      end
    end
  end

  describe '#disable_castle_rights' do
    subject(:king) { described_class.new(color: color, position: 'E1') }

    let(:castle_manager) { instance_double(CastleManager) }

    context 'when the king is white' do
      let(:color) { 'white' }

      before do
        allow(castle_manager).to receive(:remove_all_castles_for_color)
      end

      it 'sends #remove_all_castles_for_color to the given castle_manager with color' do
        king.disable_castle_rights(castle_manager)
        expect(castle_manager).to have_received(:remove_all_castles_for_color).with(color)
      end
    end

    context 'when the king is black' do
      let(:color) { 'black' }

      before do
        allow(castle_manager).to receive(:remove_all_castles_for_color)
      end

      it 'sends #remove_all_castles_for_color to the given castle_manager with color' do
        king.disable_castle_rights(castle_manager)
        expect(castle_manager).to have_received(:remove_all_castles_for_color).with(color)
      end
    end
  end

  describe '#to_fen' do
    context 'when the king is white' do
      subject(:white_king) { described_class.new(color: 'white', position: 'E1') }

      it "returns the string 'K'" do
        expected_string = 'K'
        expect(white_king.to_fen).to eq(expected_string)
      end
    end

    context 'when the king is black' do
      subject(:white_king) { described_class.new(color: 'black', position: 'E1') }

      it "returns the string 'k'" do
        expected_string = 'k'
        expect(white_king.to_fen).to eq(expected_string)
      end
    end
  end
end
