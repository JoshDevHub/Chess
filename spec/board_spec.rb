# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/square'
require_relative '../lib/board'
require_relative '../lib/piece'

describe Board do
  let(:square_class) { class_double(Square, new: nil) }
  describe '#initialize' do
    before do
      allow(square_class).to receive(:new)
    end

    it 'creates 64 square objects' do
      expect(square_class).to receive(:new).exactly(64).times
      described_class.new(square_class)
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
      expect(board_instance).to be_a(Board)
    end

    it 'sends #add_piece to E2 Square with E2 Pawn' do
      expect(e2_square).to receive(:add_piece).with(e2_pawn)
      described_class.from_fen(fen_data: fen_data, square: square_class)
    end

    it 'sends #add_piece to E1 Square with E1 King' do
      expect(e1_square).to receive(:add_piece).with(e1_king)
      described_class.from_fen(fen_data: fen_data, square: square_class)
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

  describe '#move_piece' do
    let(:piece) { instance_double(Piece, define_en_passant_square: nil) }
    subject(:game_board) { described_class.new(square_class) }
    context 'when the square is unoccupied' do
      let(:origin) { 'A1' }
      let(:target) { 'B1' }
      let(:empty_square) { instance_double(Square, unoccupied?: true) }
      before do
        allow(game_board).to receive(:access_square).with(origin).and_return(empty_square)
      end

      it 'returns nil' do
        expect(game_board.move_piece(origin, target)).to be(nil)
      end
    end

    context 'when the square is occupied' do
      context 'when the piece does not set an en passant target' do
        let(:origin) { 'A1' }
        let(:target) { 'B1' }
        let(:origin_square) { instance_double(Square, unoccupied?: false, remove_piece: piece) }
        let(:target_square) { instance_double(Square, add_piece: nil) }
        before do
          allow(game_board).to receive(:access_square).with(origin).and_return(origin_square)
          allow(game_board).to receive(:access_square).with(target).and_return(target_square)
          allow(piece).to receive(:position=)
        end

        it 'sends #remove_piece message to origin square' do
          expect(origin_square).to receive(:remove_piece)
          game_board.move_piece(origin, target)
        end

        it 'sends #define_en_passant_square to the moving piece with the target' do
          expect(piece).to receive(:define_en_passant_square).with(target)
          game_board.move_piece(origin, target)
        end

        it 'sends #position= to the moving piece with the target square name' do
          expect(piece).to receive(:position=).with(target)
          game_board.move_piece(origin, target)
        end

        it 'sends #add_piece with the moving piece to the target square' do
          expect(target_square).to receive(:add_piece).with(piece)
          game_board.move_piece(origin, target)
        end
      end
    end
  end
end

#     context 'when the piece does set an en passant target' do
#       let(:starting_square) { 'B2' }
#       let(:new_square) { 'B4' }
#       before do
#         game_board.add_piece(piece, 'B2')
#         allow(piece).to receive(:position=)
#         allow(piece).to receive(:define_en_passant_square).and_return('B3')
#       end

#       xit 'sends a new position message to the piece at the given square' do
#         expect(piece).to receive(:position=).with(new_square)
#         game_board.move_piece(starting_square, new_square)
#       end

#       xit 'moves the piece to the new square on the game board' do
#         game_board.move_piece(starting_square, new_square)
#         board_data_position = game_board.instance_variable_get(:@game_board)[4][1]
#         expect(board_data_position).to be(piece)
#       end

#       xit 'sets the en passant target square to B3' do
#         game_board.move_piece(starting_square, new_square)
#         expect(game_board.en_passant_target).to eq('B3')
#       end
#     end

#     context 'when the piece takes an opponent piece with en passant' do
#       let(:starting_square) { 'B5' }
#       let(:attacking_piece) { instance_double(Piece, color: 'white', position: starting_square) }
#       let(:target_square) { 'C6' }

#       let(:capture_square) { 'C5' }
#       let(:captured_piece) { instance_double(Piece, color: 'black', position: capture_square) }
#       before do
#         game_board.add_piece(attacking_piece, 'B5')
#         game_board.add_piece(captured_piece, 'C5')
#         allow(attacking_piece).to receive(:position=).with(target_square)
#         allow(attacking_piece).to receive(:capture_en_passant?).and_return(true)
#         allow(attacking_piece).to receive(:define_en_passant_square)
#         allow(game_board).to receive(:en_passant_target).and_return(target_square)
#       end

#       xit 'removes the captured piece' do
#         game_board.move_piece(starting_square, target_square)
#         expect(game_board.piece_at(capture_square)).to be(nil)
#       end
#     end
#   end

#   describe '#square_empty?' do
#     let(:piece) { instance_double(Piece) }
#     let(:empty_board) { described_class.new }
#     context 'when there is no piece at the board position' do
#       xit 'returns true' do
#         expect(empty_board.square_empty?('A8')).to be(true)
#       end
#     end

#     context 'when there is a piece at the board position' do
#       context 'when there is a piece at A8' do
#         before do
#           empty_board.add_piece(piece, 'A8')
#         end

#         xit 'returns false' do
#           expect(empty_board.square_empty?('A8')).to be(false)
#         end
#       end

#       context 'when there is a piece at E5' do
#         before do
#           empty_board.add_piece(piece, 'E5')
#         end

#         xit 'returns false' do
#           expect(empty_board.square_empty?('E5')).to be(false)
#         end
#       end
#     end
#   end

#   describe '#in_check' do
#     subject(:game_board) { described_class.new }
#     context 'when a white king is in check to a black piece' do
#       let(:check_square) { 'E1' }
#       let(:king) { instance_double(Piece, name: 'king', color: 'white', position: check_square) }
#       let(:black_piece) { instance_double(Piece, name: 'piece', color: 'black') }
#       before do
#         game_board.add_piece(black_piece, 'A1')
#         game_board.add_piece(king, check_square)

#         allow(black_piece).to receive(:move_list).with(game_board).and_return([check_square])
#       end

#       xit 'returns true' do
#         expect(game_board.in_check?('white')).to be(true)
#       end
#     end

#     context 'when a white king is not in check' do
#       let(:king_square) { 'E1' }
#       let(:king) { instance_double(Piece, name: 'king', color: 'white', position: king_square) }
#       let(:black_piece) { instance_double(Piece, name: 'piece', color: 'black') }
#       before do
#         game_board.add_piece(black_piece, 'A1')
#         game_board.add_piece(king, king_square)

#         allow(black_piece).to receive(:move_list).with(game_board).and_return(['B1'])
#       end

#       xit 'returns false' do
#         expect(game_board.in_check?('white')).to be(false)
#       end
#     end
#   end

#   describe '#self_check_filter' do
#     subject(:game_board) { described_class.new }
#     context 'when one of the moves in a given target list would result in check' do
#       let(:piece) { instance_double(Piece, name: 'piece', color: 'white', position: 'A1') }
#       let(:attacking_piece) { instance_double(Piece, name: 'piece', color: 'black', position: 'A2') }
#       let(:king) { instance_double(Piece, name: 'king', color: 'white', position: 'B2') }
#       let(:target_list) { %w[A3] }
#       let(:attacking_moves) { %w[A2 B2] }
#       let(:board_copy) { described_class.new }
#       before do
#         game_board.add_piece(piece, 'A2')
#         game_board.add_piece(attacking_piece, 'A1')
#         game_board.add_piece(king, 'B2')

#         board_copy.add_piece(piece, 'A2')
#         board_copy.add_piece(attacking_piece, 'A1')
#         board_copy.add_piece(king, 'B2')

#         allow(piece).to receive(:position=)
#         allow(piece).to receive(:define_en_passant_square)
#         allow(attacking_piece).to receive(:position=)
#         allow(attacking_piece).to receive(:define_en_passant_square)
#         allow(attacking_piece).to receive(:move_list).and_return(attacking_moves)
#         allow(Marshal).to receive(:load).and_return(board_copy)
#         allow(Marshal).to receive(:dump)
#       end

#       xit 'returns an empty array' do
#         expect(game_board.self_check_filter(piece, target_list)).to be_empty
#       end
#     end

#     context 'when none of the moves in the target list would result in check' do
#       let(:piece) { instance_double(Piece, name: 'piece', color: 'white', position: 'A1') }
#       let(:attacking_piece) { instance_double(Piece, name: 'piece', color: 'black', position: 'A2') }
#       let(:king) { instance_double(Piece, name: 'king', color: 'white', position: 'B2') }
#       let(:target_list) { %w[A3] }
#       let(:attacking_moves) { %w[A2 A1] }
#       let(:board_copy) { described_class.new }
#       before do
#         game_board.add_piece(piece, 'A2')
#         game_board.add_piece(attacking_piece, 'A1')
#         game_board.add_piece(king, 'B2')

#         board_copy.add_piece(piece, 'A2')
#         board_copy.add_piece(attacking_piece, 'A1')
#         board_copy.add_piece(king, 'B2')

#         allow(piece).to receive(:position=)
#         allow(piece).to receive(:define_en_passant_square)
#         allow(attacking_piece).to receive(:position=)
#         allow(attacking_piece).to receive(:define_en_passant_square)
#         allow(attacking_piece).to receive(:move_list).and_return(attacking_moves)
#         allow(Marshal).to receive(:load).and_return(board_copy)
#         allow(Marshal).to receive(:dump)
#       end

#       xit 'returns the full list of target moves' do
#         moves = target_list
#         expect(game_board.self_check_filter(piece, target_list)).to contain_exactly(*moves)
#       end
#     end
#   end

#   describe '#checkmate?' do
#     context 'when the color to check is white' do
#       let(:color) { 'white' }
#       context 'when white is in checkmate' do
#         subject(:checkmate_board) { described_class.new }
#         let(:piece) { instance_double(Piece, color: color) }
#         before do
#           checkmate_board.add_piece(piece, 'A2')
#           allow(piece).to receive(:move_list).and_return([])
#           allow(checkmate_board).to receive(:in_check?).with(color).and_return(true)
#           allow(checkmate_board).to receive(:self_check_filter).and_return([])
#         end

#         xit 'returns true' do
#           expect(checkmate_board.checkmate?(color)).to be(true)
#         end
#       end

#       context 'when white is not in checkmate' do
#         context 'when white has legal moves' do
#           subject(:checkmate_board) { described_class.new }
#           let(:piece) { instance_double(Piece, color: color) }
#           before do
#             checkmate_board.add_piece(piece, 'A2')
#             allow(piece).to receive(:move_list).and_return(['A1'])
#             allow(checkmate_board).to receive(:in_check?).with(color).and_return(true)
#             allow(checkmate_board).to receive(:self_check_filter).and_return(['A1'])
#           end

#           xit 'returns false' do
#             expect(checkmate_board.checkmate?(color)).to be(false)
#           end
#         end

#         context 'when white is not in check' do
#           subject(:checkmate_board) { described_class.new }
#           let(:piece) { instance_double(Piece, color: color) }
#           before do
#             checkmate_board.add_piece(piece, 'A2')
#             allow(piece).to receive(:move_list).and_return([])
#             allow(checkmate_board).to receive(:in_check?).with(color).and_return(false)
#             allow(checkmate_board).to receive(:self_check_filter).and_return([])
#           end

#           xit 'returns false' do
#             expect(checkmate_board.checkmate?(color)).to be(false)
#           end
#         end
#       end
#     end
#   end

#   describe '#stalemate?' do
#     let(:color) { 'black' }
#     context 'when black is in stalemate' do
#       subject(:stalemate_board) { described_class.new }
#       let(:piece) { instance_double(Piece, color: color) }
#       before do
#         stalemate_board.add_piece(piece, 'A2')
#         allow(piece).to receive(:move_list).and_return([])
#         allow(stalemate_board).to receive(:in_check?).with(color).and_return(false)
#         allow(stalemate_board).to receive(:self_check_filter).and_return([])
#       end

#       xit 'returns true' do
#         expect(stalemate_board.stalemate?(color)).to be(true)
#       end
#     end

#     context 'when black is not in stalemate' do
#       context 'when black has legal moves' do
#         subject(:stalemate_board) { described_class.new }
#         let(:piece) { instance_double(Piece, color: color) }
#         before do
#           stalemate_board.add_piece(piece, 'A2')
#           allow(piece).to receive(:move_list).and_return(['A1'])
#           allow(stalemate_board).to receive(:in_check?).with(color).and_return(false)
#           allow(stalemate_board).to receive(:self_check_filter).and_return(['A1'])
#         end

#         xit 'returns false' do
#           expect(stalemate_board.stalemate?(color)).to be(false)
#         end
#       end

#       context 'when black is in check' do
#         subject(:stalemate_board) { described_class.new }
#         let(:piece) { instance_double(Piece, color: color) }
#         before do
#           stalemate_board.add_piece(piece, 'A2')
#           allow(piece).to receive(:move_list).and_return([])
#           allow(stalemate_board).to receive(:in_check?).with(color).and_return(true)
#           allow(stalemate_board).to receive(:self_check_filter).and_return([])
#         end

#         xit 'returns false' do
#           expect(stalemate_board.stalemate?(color)).to be(false)
#         end
#       end
#     end
#   end
# end
