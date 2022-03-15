# frozen_string_literal: true

require_relative '../lib/coordinate'
require_relative '../lib/colorize_output'
require_relative '../lib/square'
require_relative '../lib/piece'
require_relative '../lib/pieces/null_piece'

describe Square do
  let(:piece) { instance_double(Piece, to_s: 'piece', absent?: false) }
  describe '#unoccupied?' do
    context 'when the square is empty' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'returns true' do
        expect(square.unoccupied?).to be(true)
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      it 'returns false' do
        expect(square.unoccupied?).to be(false)
      end
    end
  end

  describe '#add_piece' do
    context 'when the square is unoccupied' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'changes @piece to the given piece' do
        expect { square.add_piece(piece) }.to change { square.piece }.to(piece)
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      let(:new_piece) { instance_double(Piece) }
      it 'changes @piece from the current piece to the given piece' do
        expect { square.add_piece(new_piece) }.to change { square.piece }.from(piece).to(new_piece)
      end
    end
  end

  describe '#remove_piece' do
    context 'when the square is unoccupied' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'returns a NullPiece' do
        expect(square.remove_piece).to be_a(NullPiece)
      end

      it 'does not change the value held at @piece' do
        expect { square.remove_piece }.to_not change { square.piece }
        square.remove_piece
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      it 'returns the removed piece' do
        expect(square.remove_piece).to eq(piece)
      end

      it 'changes @piece from piece to a NullPiece' do
        expect { square.remove_piece }.to change { square.piece }.from(piece).to(NullPiece)
      end
    end
  end

  describe '#to_s' do
    context 'when the square should be gray' do
      context 'when the square is empty' do
        subject(:square) { described_class.new(name: 'B1') }
        it 'returns a string with three spaces and ANSI colors for black foreground with gray background' do
          black_fg_code = "\e[0m\e[0m"
          gray_bg_code = "\e[47m\e[30m"
          spaces = '   '
          expected_output = "#{gray_bg_code}#{spaces}#{black_fg_code}"
          expect(square.to_s).to eq(expected_output)
        end
      end

      context 'when the square has a piece' do
        subject(:square) { described_class.new(name: 'B1', piece: piece) }
        it 'returns a string with the piece and ANSI colors for black foreground with gray background' do
          black_fg_code = "\e[0m\e[0m"
          gray_bg_code = "\e[47m\e[30m"
          piece_string = piece.to_s
          expected_output = "#{gray_bg_code}#{piece_string}#{black_fg_code}"
          expect(square.to_s).to eq(expected_output)
        end
      end
    end
    context 'when the square should be purple' do
      context 'when the square is empty' do
        subject(:square) { described_class.new(name: 'A1') }
        it 'returns a string with three spaces and ANSI colors for black foreground with purple background' do
          black_fg_code = "\e[0m\e[0m"
          purple_bg_code = "\e[48;2;136;119;183m\e[30m"
          spaces = '   '
          expected_output = "#{purple_bg_code}#{spaces}#{black_fg_code}"
          expect(square.to_s).to eq(expected_output)
        end
      end

      context 'when the square has a piece' do
        subject(:square) { described_class.new(name: 'A1', piece: piece) }
        it 'returns a string with three spaces and ANSI colors for black foreground with purple background' do
          black_fg_code = "\e[0m\e[0m"
          purple_bg_code = "\e[48;2;136;119;183m\e[30m"
          piece_string = piece.to_s
          expected_output = "#{purple_bg_code}#{piece_string}#{black_fg_code}"
          expect(square.to_s).to eq(expected_output)
        end
      end
    end
  end

  describe '#to_string_with_moves' do
    context 'when the square name is not in the move list' do
      subject(:square) { described_class.new(name: 'A1') }
      let(:move_list) { %w[E1 E2 E3 A2] }
      it 'sends #to_s to self' do
        expect(square).to receive(:to_s)
        square.to_string_with_moves(move_list)
      end
    end

    context 'when the square name is in the given move list' do
      context 'when the square is unoccupied' do
        context 'when the square is a dark square' do
          subject(:square) { described_class.new(name: 'A1') }
          let(:move_list) { ['A1'] }
          it 'returns a black bullet unicode surrounded by two spaces and a purple bg color' do
            expected_output = "\e[48;2;136;119;183m\e[30m • \e[0m\e[0m"
            expect(square.to_string_with_moves(move_list)).to eq(expected_output)
          end
        end

        context 'when the square is a light square' do
          subject(:square) { described_class.new(name: 'A1') }
          let(:move_list) { ['A2'] }
          it 'returns a black bullet unicode surrounded by two spaces and a gray bg color' do
            expected_output = "\e[48;2;136;119;183m\e[30m   \e[0m\e[0m"
            expect(square.to_string_with_moves(move_list)).to eq(expected_output)
          end
        end
      end
    end

    context 'when the square is occupied' do
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      let(:move_list) { ['A1'] }
      it 'sends #to_s to piece' do
        expect(piece).to receive(:to_s)
        square.to_string_with_moves(move_list)
      end

      it 'sends #bg_red to self with the piece string' do
        piece_string = "\e[30mpiece\e[0m"
        expect(square).to receive(:bg_red).with(piece_string)
        square.to_string_with_moves(move_list)
      end
    end
  end

  describe '#piece_color' do
    context 'when the square is empty' do
      subject(:square) { described_class.new(name: 'A1') }
      it 'returns nil' do
        expect(square.piece_color).to be(nil)
      end
    end

    context 'when the color of the piece in the square is orange' do
      let(:color) { 'orange' }
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      before do
        allow(piece).to receive(:color).and_return(color)
      end

      it "returns the string 'orange'" do
        expect(square.piece_color).to eq(color)
      end
    end

    context 'when the color of the piece in the square is black' do
      let(:color) { 'black' }
      subject(:square) { described_class.new(name: 'A1', piece: piece) }
      before do
        allow(piece).to receive(:color).and_return(color)
      end

      it "returns the string 'black'" do
        expect(square.piece_color).to eq(color)
      end
    end
  end

  describe '#occupied_by_king?' do
    context 'when the square has a white king' do
      let(:color) { 'white' }
      let(:king) { instance_double(Piece, name: 'king', color: color) }
      subject(:king_square) { described_class.new(name: 'E4', piece: king) }
      it 'returns true' do
        expect(king_square.occupied_by_king?(color)).to be(true)
      end
    end

    context 'when the square has a black king' do
      let(:color) { 'black' }
      let(:king) { instance_double(Piece, name: 'king', color: color) }
      subject(:king_square) { described_class.new(name: 'E8', piece: king) }
      it 'returns true' do
        expect(king_square.occupied_by_king?(color)).to be(true)
      end
    end

    context 'when the square does not have a king' do
      let(:color) { 'white' }
      let(:piece) { instance_double(Piece, name: 'piece', color: color) }
      subject(:generic_square) { described_class.new(name: 'E4', piece: piece) }
      it 'returns false' do
        expect(generic_square.occupied_by_king?(color)).to be(false)
      end
    end

    context 'when the square has no piece' do
      context 'when the color is black' do
        let(:color) { 'black' }
        subject(:empty_square) { described_class.new(name: 'E8') }
        it 'returns false' do
          expect(empty_square.occupied_by_king?(color)).to be(false)
        end
      end

      context 'when the color is white' do
        let(:color) { 'white' }
        subject(:empty_square) { described_class.new(name: 'E8') }
        it 'returns false' do
          expect(empty_square.occupied_by_king?(color)).to be(false)
        end
      end
    end
  end
end
