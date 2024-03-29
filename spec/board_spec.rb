# frozen_string_literal: true

RSpec.describe Board do
  let(:square_class) { class_double(Square, new: nil) }

  describe '#initialize' do
    before do
      allow(square_class).to receive(:new)
    end

    it 'creates 64 square objects' do
      described_class.new(square_class)
      expect(square_class).to have_received(:new).exactly(64).times
    end
  end

  describe '#self.from_fen' do
    let(:fen_data) { [e2_pawn, e1_king] }
    let(:e2_pawn) { instance_double(Piece, position: 'E2') }
    let(:e1_king) { instance_double(Piece, position: 'E1') }
    let(:generic_square) { instance_double(Square, name: 'square') }
    let(:e2_square) { instance_double(Square, name: 'E2') }
    let(:e1_square) { instance_double(Square, name: 'E1') }

    before do
      allow(square_class).to receive(:new).and_return(generic_square)
      allow(square_class).to receive(:new).with(name: 'E2').and_return(e2_square)
      allow(square_class).to receive(:new).with(name: 'E1').and_return(e1_square)
      allow(e1_square).to receive(:add_piece)
      allow(e2_square).to receive(:add_piece)
    end

    it 'returns a board object' do
      board_instance = described_class.from_fen(fen_data: fen_data, square: square_class)
      expect(board_instance).to be_a(described_class)
    end

    it 'sends #add_piece to E2 Square with E2 Pawn' do
      described_class.from_fen(fen_data: fen_data, square: square_class)
      expect(e2_square).to have_received(:add_piece).with(e2_pawn)
    end

    it 'sends #add_piece to E1 Square with E1 King' do
      described_class.from_fen(fen_data: fen_data, square: square_class)
      expect(e1_square).to have_received(:add_piece).with(e1_king)
    end
  end

  describe '#access_square' do
    subject(:game_board) { described_class.new(Square) }

    it 'returns the square with the given name A1' do
      square_name = 'A1'
      square = game_board.access_square(square_name)
      expect(square.name).to eq(square_name)
    end

    it 'returns the square with the given name C4' do
      square_name = 'C4'
      square = game_board.access_square(square_name)
      expect(square.name).to eq(square_name)
    end
  end

  describe '#to_fen' do
    context 'when the board is empty' do
      subject(:game_board) { described_class.new(Square) }

      it "returns the string '8/8/8/8/8/8/8/8'" do
        expected_output = '8/8/8/8/8/8/8/8'
        expect(game_board.to_fen).to eq(expected_output)
      end
    end
  end

  describe '#move_list_from_origin' do
    subject(:game_board) { described_class.new(Square) }

    let(:origin_square) { instance_double(Square) }
    let(:piece) { instance_double(Piece) }
    let(:castle_manager) { instance_double(CastleManager) }
    let(:move_list) { [] }
    let(:origin) { 'A1' }

    before do
      allow(game_board).to receive(:access_square).with('A1').and_return(origin_square)
      allow(origin_square).to receive(:piece).and_return(piece)
      allow(piece).to receive(:move_list).with(game_board, castle_manager).and_return(move_list)
      allow(game_board).to receive(:self_check_filter).with(piece, move_list)
    end

    it 'sends a #piece to the origin square' do
      game_board.move_list_from_origin(origin, castle_manager)
      expect(origin_square).to have_received(:piece)
    end

    it 'sends #move_list to the piece' do
      game_board.move_list_from_origin(origin, castle_manager)
      expect(piece).to have_received(:move_list).with(game_board, castle_manager)
    end
  end

  describe '#move_piece' do
    subject(:game_board) { described_class.new(square_class) }

    let(:piece) { instance_double(Piece, define_en_passant_square: nil) }
    let(:target_piece) { instance_double(Piece) }

    context 'when the square is unoccupied' do
      let(:origin) { 'A1' }
      let(:target) { 'B1' }
      let(:empty_square) { instance_double(Square, unoccupied?: true) }

      before do
        allow(game_board).to receive(:access_square).with(origin).and_return(empty_square)
      end

      it 'returns nil' do
        expect(game_board.move_piece(origin, target)).to be_nil
      end
    end

    context 'when the square is occupied' do
      context 'when the piece does not set an en passant target' do
        let(:origin) { 'A1' }
        let(:target) { 'B1' }
        let(:origin_square) { instance_double(Square, unoccupied?: false, remove_piece: piece) }
        let(:target_square) { instance_double(Square, piece: target_piece, add_piece: nil) }

        before do
          allow(game_board).to receive(:access_square).with(origin).and_return(origin_square)
          allow(game_board).to receive(:access_square).with(target).and_return(target_square)
          allow(piece).to receive(:move_position)
        end

        it 'sends #remove_piece message to origin square' do
          game_board.move_piece(origin, target)
          expect(origin_square).to have_received(:remove_piece)
        end

        it 'sends #define_en_passant_square to the moving piece with the target' do
          game_board.move_piece(origin, target)
          expect(piece).to have_received(:define_en_passant_square).with(target)
        end

        it 'sends #move_position to the moving piece with the target square name' do
          game_board.move_piece(origin, target)
          expect(piece).to have_received(:move_position).with(target)
        end

        it 'sends #add_piece with the moving piece to the target square' do
          game_board.move_piece(origin, target)
          expect(target_square).to have_received(:add_piece).with(piece)
        end

        it 'returns the piece at the target square' do
          expect(game_board.move_piece(origin, target)).to be(target_piece)
        end
      end

      context 'when the piece does set an en passant target square' do
        let(:origin) { 'E2' }
        let(:target) { 'E4' }
        let(:origin_square) { instance_double(Square, unoccupied?: false, remove_piece: piece) }
        let(:target_square) { instance_double(Square, piece: target_piece, add_piece: nil) }

        before do
          allow(game_board).to receive(:access_square).with(origin).and_return(origin_square)
          allow(game_board).to receive(:access_square).with(target).and_return(target_square)
          allow(piece).to receive(:move_position)
          allow(piece).to receive(:define_en_passant_square).with(target).and_return('E3')
        end

        it 'sends #remove_piece message to origin square' do
          game_board.move_piece(origin, target)
          expect(origin_square).to have_received(:remove_piece)
        end

        it 'sends #define_en_passant_square to the moving piece with the target' do
          game_board.move_piece(origin, target)
          expect(piece).to have_received(:define_en_passant_square).with(target)
        end

        it 'changes @en_passant_target to the return given by define_en_passant_square' do
          return_square = piece.define_en_passant_square(target)
          expect { game_board.move_piece(origin, target) }
            .to change(game_board, :en_passant_target).to(return_square)
        end

        it 'sends #move_position to the moving piece with the target square name' do
          game_board.move_piece(origin, target)
          expect(piece).to have_received(:move_position).with(target)
        end

        it 'sends #add_piece with the moving piece to the target square' do
          game_board.move_piece(origin, target)
          expect(target_square).to have_received(:add_piece).with(piece)
        end

        it 'returns the piece at the target square' do
          expect(game_board.move_piece(origin, target)).to be(target_piece)
        end
      end

      context 'when the piece takes an opponent piece with en passant' do
        let(:origin) { 'E4' }
        let(:target) { 'D3' }
        let(:piece) { instance_double(Piece, color: 'black') }
        let(:origin_square) { instance_double(Square, unoccupied?: false, remove_piece: piece) }
        let(:target_square) { instance_double(Square, piece: target_piece, add_piece: nil) }
        let(:capture_square) { instance_double(Square, name: 'D4', remove_piece: nil) }

        before do
          allow(game_board).to receive(:access_square).with(origin).and_return(origin_square)
          allow(game_board).to receive(:access_square).with(target).and_return(target_square)
          allow(game_board).to receive(:access_square).with('D4').and_return(capture_square)
          allow(game_board).to receive(:en_passant_target).and_return(target)
          allow(piece).to receive(:move_position)
          allow(piece).to receive(:define_en_passant_square).with(target)
          allow(piece).to receive(:capture_en_passant?).with(target).and_return(true)
        end

        it 'sends #remove_piece to the origin square' do
          game_board.move_piece(origin, target)
          expect(origin_square).to have_received(:remove_piece)
        end

        it 'sends #define_en_passant_square to the moving piece with the target' do
          game_board.move_piece(origin, target)
          expect(piece).to have_received(:define_en_passant_square).with(target)
        end

        it 'sends #move_position to the moving piece with the target square name' do
          game_board.move_piece(origin, target)
          expect(piece).to have_received(:move_position).with(target)
        end

        it 'sends #add_piece with the moving piece to the target square' do
          game_board.move_piece(origin, target)
          expect(target_square).to have_received(:add_piece).with(piece)
        end

        it 'sends #remove_piece to the capture square' do
          game_board.move_piece(origin, target)
          expect(capture_square).to have_received(:remove_piece)
        end

        it 'returns the piece at the target square' do
          expect(game_board.move_piece(origin, target)).to be(target_piece)
        end
      end
    end
  end

  describe '#in_check' do
    subject(:game_board) { described_class.new(square_class) }

    context 'when a white king is in check to a black piece' do
      let(:color) { 'white' }
      let(:empty_squares) { instance_double(Square, occupied_by_king?: false, piece_color: nil) }
      let(:king_square) { instance_double(Square, name: 'E1', piece_color: 'white', occupied_by_king?: true) }
      let(:attacker_square) { instance_double(Square, piece_color: 'black', occupied_by_king?: false, piece: attacker) }
      let(:attacker) { instance_double(Piece, move_list: ['E1']) }

      before do
        allow(square_class).to receive(:new).and_return(empty_squares)
        allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
        allow(square_class).to receive(:new).with(name: 'E2').and_return(attacker_square)
      end

      it 'returns true' do
        expect(game_board.in_check?('white')).to be(true)
      end
    end

    context 'when a white king is not in check to a black piece' do
      let(:color) { 'white' }
      let(:empty_squares) { instance_double(Square, occupied_by_king?: false, piece_color: nil) }
      let(:king_square) { instance_double(Square, name: 'E1', piece_color: 'white', occupied_by_king?: true) }
      let(:attacker_square) { instance_double(Square, piece_color: 'black', occupied_by_king?: false, piece: attacker) }
      let(:attacker) { instance_double(Piece, move_list: ['E3']) }

      before do
        allow(square_class).to receive(:new).and_return(empty_squares)
        allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
        allow(square_class).to receive(:new).with(name: 'E2').and_return(attacker_square)
      end

      it 'returns false' do
        expect(game_board.in_check?('white')).to be(false)
      end
    end

    context 'when a black king is in check to a white piece' do
      let(:color) { 'black' }
      let(:empty_squares) { instance_double(Square, occupied_by_king?: false, piece_color: nil) }
      let(:king_square) { instance_double(Square, name: 'E8', piece_color: color, occupied_by_king?: true) }
      let(:attacker_square) { instance_double(Square, piece_color: 'white', occupied_by_king?: false, piece: attacker) }
      let(:attacker) { instance_double(Piece, move_list: ['E8']) }

      before do
        allow(square_class).to receive(:new).and_return(empty_squares)
        allow(square_class).to receive(:new).with(name: 'E8').and_return(king_square)
        allow(square_class).to receive(:new).with(name: 'E7').and_return(attacker_square)
      end

      it 'returns true' do
        expect(game_board.in_check?('black')).to be(true)
      end
    end

    context 'when a black king is not in check to a white piece' do
      let(:color) { 'black' }
      let(:empty_squares) { instance_double(Square, occupied_by_king?: false, piece_color: nil) }
      let(:king_square) { instance_double(Square, name: 'E8', piece_color: 'black', occupied_by_king?: true) }
      let(:attacker_square) { instance_double(Square, piece_color: 'white', occupied_by_king?: false, piece: attacker) }
      let(:attacker) { instance_double(Piece, move_list: ['E6']) }

      before do
        allow(square_class).to receive(:new).and_return(empty_squares)
        allow(square_class).to receive(:new).with(name: 'E8').and_return(king_square)
        allow(square_class).to receive(:new).with(name: 'E6').and_return(attacker_square)
      end

      it 'returns false' do
        expect(game_board.in_check?('black')).to be(false)
      end
    end
  end

  describe '#self_check_filter' do
    subject(:game_board) { described_class.new(square_class) }

    context 'when all of the moves in a target list would result in check' do
      let(:origin) { 'B2' }
      let(:moving_piece) { instance_double(Piece, position: origin, color: 'white') }
      let(:target_list) { %w[A1 A2 A3] }
      let(:in_check_board) { described_class.new(square_class) }

      before do
        allow(Marshal).to receive(:load).and_return(in_check_board)
        allow(Marshal).to receive(:dump)
        allow(in_check_board).to receive(:in_check?).and_return(true)
        allow(in_check_board).to receive(:move_piece).with(origin, 'A1')
        allow(in_check_board).to receive(:move_piece).with(origin, 'A2')
        allow(in_check_board).to receive(:move_piece).with(origin, 'A3')
      end

      it 'returns an empty array' do
        expect(game_board.self_check_filter(moving_piece, target_list)).to be_empty
      end
    end

    context 'when none of the moves in a target list would result in check' do
      let(:origin) { 'B2' }
      let(:moving_piece) { instance_double(Piece, position: origin, color: 'white') }
      let(:target_list) { %w[A1 A2 A3] }
      let(:in_check_board) { described_class.new(square_class) }

      before do
        allow(Marshal).to receive(:load).and_return(in_check_board)
        allow(Marshal).to receive(:dump)
        allow(in_check_board).to receive(:in_check?).and_return(false)
        allow(in_check_board).to receive(:move_piece).with(origin, 'A1')
        allow(in_check_board).to receive(:move_piece).with(origin, 'A2')
        allow(in_check_board).to receive(:move_piece).with(origin, 'A3')
      end

      it 'returns an empty array' do
        expect(game_board.self_check_filter(moving_piece, target_list)).to eq(target_list)
      end
    end
  end

  describe '#checkmate?' do
    context 'when the color to check is white' do
      let(:color) { 'white' }

      context 'when white is in checkmate' do
        subject(:checkmate_board) { described_class.new(square_class) }

        let(:piece) { instance_double(Piece, color: color) }
        let(:king_square) do
          instance_double(
            Square,
            name: 'E1',
            piece_color: color,
            occupied_by_king?: true,
            piece: piece
          )
        end
        let(:empty_square) do
          instance_double(
            Square,
            unoccupied?: true,
            occupied_by_king?: false,
            piece: NullPiece,
            piece_color: nil
          )
        end

        before do
          allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
          allow(square_class).to receive(:new).and_return(empty_square)
          allow(checkmate_board).to receive(:in_check?).with(color).and_return(true)
          allow(checkmate_board).to receive(:self_check_filter).and_return([])
        end

        it 'returns true' do
          expect(checkmate_board.checkmate?(color)).to be(true)
        end
      end

      context 'when white is not in checkmate' do
        context 'when white is not in check' do
          subject(:checkmate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(checkmate_board).to receive(:in_check?).with(color).and_return(false)
            allow(checkmate_board).to receive(:self_check_filter).and_return([])
          end

          it 'returns false' do
            expect(checkmate_board.checkmate?(color)).to be(false)
          end
        end

        context 'when white is in check with legal moves' do
          subject(:checkmate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(checkmate_board).to receive(:in_check?).with(color).and_return(false)
            allow(checkmate_board).to receive(:self_check_filter).and_return(['E2'])
          end

          it 'returns false' do
            expect(checkmate_board.checkmate?(color)).to be(false)
          end
        end
      end
    end

    context 'when the color to check is black' do
      let(:color) { 'black' }

      context 'when white is in checkmate' do
        subject(:checkmate_board) { described_class.new(square_class) }

        let(:piece) { instance_double(Piece, color: color) }
        let(:king_square) do
          instance_double(
            Square,
            name: 'E1',
            piece_color: color,
            occupied_by_king?: true,
            piece: piece
          )
        end
        let(:empty_square) do
          instance_double(
            Square,
            unoccupied?: true,
            occupied_by_king?: false,
            piece: NullPiece,
            piece_color: nil
          )
        end

        before do
          allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
          allow(square_class).to receive(:new).and_return(empty_square)
          allow(checkmate_board).to receive(:in_check?).with(color).and_return(true)
          allow(checkmate_board).to receive(:self_check_filter).and_return([])
        end

        it 'returns true' do
          expect(checkmate_board.checkmate?(color)).to be(true)
        end
      end

      context 'when white is not in checkmate' do
        context 'when white is not in check' do
          subject(:checkmate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(checkmate_board).to receive(:in_check?).with(color).and_return(false)
            allow(checkmate_board).to receive(:self_check_filter).and_return([])
          end

          it 'returns false' do
            expect(checkmate_board.checkmate?(color)).to be(false)
          end
        end

        context 'when white is in check with legal moves' do
          subject(:checkmate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(checkmate_board).to receive(:in_check?).with(color).and_return(false)
            allow(checkmate_board).to receive(:self_check_filter).and_return(['E2'])
          end

          it 'returns false' do
            expect(checkmate_board.checkmate?(color)).to be(false)
          end
        end
      end
    end
  end

  describe '#stalemate?' do
    context 'when the color to check is white' do
      let(:color) { 'white' }

      context 'when white is in stalemate' do
        subject(:stalemate_board) { described_class.new(square_class) }

        let(:piece) { instance_double(Piece, color: color) }
        let(:king_square) do
          instance_double(
            Square,
            name: 'E1',
            piece_color: color,
            occupied_by_king?: true,
            piece: piece
          )
        end
        let(:empty_square) do
          instance_double(
            Square,
            unoccupied?: true,
            occupied_by_king?: false,
            piece: NullPiece,
            piece_color: nil
          )
        end

        before do
          allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
          allow(square_class).to receive(:new).and_return(empty_square)
          allow(stalemate_board).to receive(:in_check?).with(color).and_return(false)
          allow(stalemate_board).to receive(:self_check_filter).and_return([])
        end

        it 'returns true' do
          expect(stalemate_board.stalemate?(color)).to be(true)
        end
      end

      context 'when white is not in stalemate' do
        context 'when white is in check' do
          subject(:stalemate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(stalemate_board).to receive(:in_check?).with(color).and_return(true)
            allow(stalemate_board).to receive(:self_check_filter).and_return([])
          end

          it 'returns false' do
            expect(stalemate_board.stalemate?(color)).to be(false)
          end
        end

        context 'when white has legal moves' do
          subject(:stalemate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(stalemate_board).to receive(:in_check?).with(color).and_return(false)
            allow(piece).to receive(:move_list).and_return(['E2'])
            allow(stalemate_board).to receive(:self_check_filter).and_return(['E2'])
          end

          it 'returns false' do
            expect(stalemate_board.stalemate?(color)).to be(false)
          end
        end
      end
    end

    context 'when the color to check is black' do
      let(:color) { 'black' }

      context 'when black is in stalemate' do
        subject(:stalemate_board) { described_class.new(square_class) }

        let(:piece) { instance_double(Piece, color: color) }
        let(:king_square) do
          instance_double(
            Square,
            name: 'E1',
            piece_color: color,
            occupied_by_king?: true,
            piece: piece
          )
        end
        let(:empty_square) do
          instance_double(
            Square,
            unoccupied?: true,
            occupied_by_king?: false,
            piece: NullPiece,
            piece_color: nil
          )
        end

        before do
          allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
          allow(square_class).to receive(:new).and_return(empty_square)
          allow(stalemate_board).to receive(:in_check?).with(color).and_return(true)
          allow(stalemate_board).to receive(:self_check_filter).and_return([])
        end

        it 'returns true' do
          expect(stalemate_board.checkmate?(color)).to be(true)
        end
      end

      context 'when black is not in checkmate' do
        context 'when black is not in check' do
          subject(:stalemate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(stalemate_board).to receive(:in_check?).with(color).and_return(false)
            allow(stalemate_board).to receive(:self_check_filter).and_return([])
          end

          it 'returns false' do
            expect(stalemate_board.checkmate?(color)).to be(false)
          end
        end

        context 'when black is in check with legal moves' do
          subject(:stalemate_board) { described_class.new(square_class) }

          let(:piece) { instance_double(Piece, color: color) }
          let(:king_square) do
            instance_double(
              Square,
              name: 'E1',
              piece_color: color,
              occupied_by_king?: true,
              piece: piece
            )
          end
          let(:empty_square) do
            instance_double(
              Square,
              unoccupied?: true,
              occupied_by_king?: false,
              piece: NullPiece,
              piece_color: nil
            )
          end

          before do
            allow(square_class).to receive(:new).with(name: 'E1').and_return(king_square)
            allow(square_class).to receive(:new).and_return(empty_square)
            allow(stalemate_board).to receive(:in_check?).with(color).and_return(false)
            allow(stalemate_board).to receive(:self_check_filter).and_return(['E2'])
          end

          it 'returns false' do
            expect(stalemate_board.checkmate?(color)).to be(false)
          end
        end
      end
    end
  end
end
