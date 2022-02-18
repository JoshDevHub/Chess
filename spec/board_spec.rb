# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/board'
require_relative '../lib/piece'

describe Board do
  describe '#self.from_fen' do
    let(:e2_pawn) { instance_double(Piece, position: 'E2') }
    let(:king) { instance_double(Piece, position: 'E1') }
    let(:fen_data) { [e2_pawn, king] }
    let(:board_instance) { described_class.from_fen(fen_data: fen_data) }

    it 'returns a Board instance' do
      expect(board_instance).to be_a(Board)
    end

    it 'places the pawn on E2' do
      y_pos = 6
      x_pos = 4
      e2_piece = board_instance.instance_variable_get(:@game_board)[y_pos][x_pos]
      expect(e2_piece).to be(e2_pawn)
    end

    it 'places the king on E1' do
      y_pos = 7
      x_pos = 4
      e1_piece = board_instance.instance_variable_get(:@game_board)[y_pos][x_pos]
      expect(e1_piece).to be(king)
    end

    it 'places nothing on F5' do
      y_pos = 3
      x_pos = 5
      empty_f5 = board_instance.instance_variable_get(:@game_board)[y_pos][x_pos]
      expect(empty_f5).to be(nil)
    end
  end

  describe '#add_piece' do
    let(:empty_board) { described_class.new }
    let(:piece) { instance_double(Piece) }
    context 'when a piece is added to A8' do
      before do
        empty_board.add_piece(piece, 'A8')
      end

      it 'adds the piece to the corresponding coordinates of @game_board' do
        y_pos = 0
        x_pos = 0
        square = empty_board.instance_variable_get(:@game_board)[y_pos][x_pos]
        expect(square).to be(piece)
      end
    end

    context 'when a piece is added to C4' do
      before do
        empty_board.add_piece(piece, 'C4')
      end

      it 'adds the piece to the corresponding coordinates of @game_board' do
        y_pos = 4
        x_pos = 2
        square = empty_board.instance_variable_get(:@game_board)[y_pos][x_pos]
        expect(square).to be(piece)
      end
    end
  end

  describe '#piece_at' do
    let(:empty_board) { described_class.new }
    context 'when there is no piece at the board position' do
      it 'returns nil' do
        x_pos = 0
        y_pos = 0
        empty_square = empty_board.instance_variable_get(:@game_board)[y_pos][x_pos]
        expect(empty_square).to be(nil)
      end
    end

    context 'when there is a piece at the given position' do
      subject(:board_with_pieces) { described_class.new }
      let(:found_piece) { instance_double(Piece) }
      before do
        board_with_pieces.add_piece(found_piece, 'A8')
      end

      it 'returns the piece at the given position' do
        x_pos = 0
        y_pos = 0
        square_with_piece = board_with_pieces.instance_variable_get(:@game_board)[y_pos][x_pos]
        expect(square_with_piece).to be(found_piece)
      end
    end
  end

  describe '#color_at' do
    let(:piece) { instance_double(Piece) }
    subject(:board) { described_class.new }
    context 'when the position on the board is empty' do
      it 'returns nil for the empty position' do
        expect(board.color_at('B5')).to be(nil)
      end
    end

    context 'when C5 has a piece' do
      before do
        square_to_check = 'C5'
        board.add_piece(piece, square_to_check)
      end

      it 'sends #color message to the piece on C5' do
        expect(piece).to receive(:color)
        board.color_at('C5')
      end
    end

    context 'when G8 has a piece' do
      before do
        square_to_check = 'G8'
        board.add_piece(piece, square_to_check)
      end

      it 'sends #color message to the piece on G8' do
        expect(piece).to receive(:color)
        board.color_at('G8')
      end
    end
  end

  describe '#move_piece' do
    let(:piece) {  instance_double(Piece) }
    subject(:game_board) { described_class.new }
    context 'when there is no piece at the position' do
      it 'returns nil' do
        position = 'E4'
        new_position = 'E5'
        expect(game_board.move_piece(position, new_position)).to be(nil)
      end
    end

    context 'when there is a piece at the given position' do
      before do
        game_board.add_piece(piece, 'F5')
        allow(piece).to receive(:position=)
      end

      it 'sends a new position message to the piece at the given square' do
        starting_square = 'F5'
        new_square = 'F6'
        expect(piece).to receive(:position=).with(new_square)
        game_board.move_piece(starting_square, new_square)
      end

      it 'moves the piece to the new square' do
        starting_square = 'F5'
        new_square = 'F6'
        game_board.move_piece(starting_square, new_square)
        new_square_board_position = game_board.instance_variable_get(:@game_board)[2][5]
        expect(new_square_board_position).to be(piece)
      end
    end
  end

  describe '#square_empty?' do
    let(:piece) { instance_double(Piece) }
    let(:empty_board) { described_class.new }
    context 'when there is no piece at the board position' do
      it 'returns true' do
        expect(empty_board.square_empty?('A8')).to be(true)
      end
    end

    context 'when there is a piece at the board position' do
      context 'when there is a piece at A8' do
        before do
          empty_board.add_piece(piece, 'A8')
        end

        it 'returns false' do
          expect(empty_board.square_empty?('A8')).to be(false)
        end
      end

      context 'when there is a piece at E5' do
        before do
          empty_board.add_piece(piece, 'E5')
        end

        it 'returns false' do
          expect(empty_board.square_empty?('E5')).to be(false)
        end
      end
    end
  end
end
