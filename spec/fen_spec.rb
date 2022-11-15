# frozen_string_literal: true

RSpec.describe FEN do
  let(:piece) { class_double(Piece) }
  describe '#piece_info' do
    context 'when the board is the starting board' do
      let(:starting_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_board) { described_class.new(starting_string, piece) }

      before do
        allow(piece).to receive(:from_fen)
      end

      it 'sends Piece #from_fen exactly 32 times' do
        expect(piece).to receive(:from_fen).exactly(32).times
        starting_board.piece_info
      end

      it 'sends Piece #from_fen with r and A8' do
        expect(piece).to receive(:from_fen).with('r', 'A8')
        starting_board.piece_info
      end

      it 'sends Piece #from_fen with K and D1' do
        expect(piece).to receive(:from_fen).with('K', 'E1')
        starting_board.piece_info
      end

      it 'does not send Piece #from_fen with p and G4' do
        expect(piece).not_to receive(:from_fen).with('p', 'G4')
        starting_board.piece_info
      end
    end

    context 'when the fen string is random' do
      let(:random_fen) { '5b2/7P/r1p5/3bnP1Q/1kP1p3/3r4/4BP1K/2R5 w - - 0 1' }
      subject(:fen_data) { described_class.new(random_fen, piece) }

      before do
        allow(piece).to receive(:from_fen)
      end

      it 'sends Piece #from_fen exactly 16 times' do
        expect(piece).to receive(:from_fen).exactly(16).times
        fen_data.piece_info
      end

      it 'sends Piece #from_fen with R and C1' do
        expect(piece).to receive(:from_fen).with('R', 'C1')
        fen_data.piece_info
      end
    end
  end

  describe '#active_color' do
    context 'when white is the active color' do
      let(:starting_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_board) { described_class.new(starting_string, piece) }
      it 'returns white' do
        expected_color = 'white'
        expect(starting_board.active_color).to eq(expected_color)
      end
    end

    context 'when black is the active color' do
      let(:random_fen) { '8/R4KP1/5p2/1p6/4pPR1/P6k/pPb4P/3N2b1 b - - 0 1' }
      subject(:fen_info) { described_class.new(random_fen, piece) }
      it 'returns black' do
        expected_color = 'black'
        expect(fen_info.active_color).to eq(expected_color)
      end
    end
  end

  describe '#en_passant_target' do
    context 'when the target is empty' do
      let(:fen_string) { 'rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2' }
      subject(:no_en_passant) { described_class.new(fen_string, piece) }
      it 'returns nil' do
        expect(no_en_passant.en_passant_target).to be(nil)
      end
    end

    context 'when the target is defined' do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1' }
      subject(:fen_with_en_passant) { described_class.new(fen_string, piece) }
      it 'returns the en passant target square' do
        target = 'E3'
        expect(fen_with_en_passant.en_passant_target).to eq(target)
      end
    end
  end

  describe '#half_move_clock' do
    context 'when the clock is zero' do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:starting_fen) { described_class.new(fen_string, piece) }
      it 'returns 0' do
        expected_number = 0
        expect(starting_fen.half_move_clock).to eq(expected_number)
      end
    end

    context 'when the clock is one' do
      let(:fen_string) { 'rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2' }
      subject(:fen) { described_class.new(fen_string, piece) }
      it 'returns 1' do
        expected_number = 1
        expect(fen.half_move_clock).to eq(expected_number)
      end
    end
  end

  describe '#full_move_clock' do
    context "when it's the first move of the game" do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      subject(:first_move) { described_class.new(fen_string, piece) }
      it 'returns 1' do
        expected_number = 1
        expect(first_move.full_move_clock).to eq(expected_number)
      end
    end

    context "when it's the fourth move of the game" do
      let(:fen_string) { 'rnbqkb1r/pp2pppp/5n2/2pp4/3P1B2/4P3/PPP2PPP/RN1QKBNR w KQkq - 0 4' }
      subject(:fourth_move) { described_class.new(fen_string, piece) }
      it 'returns 4' do
        expected_number = 4
        expect(fourth_move.full_move_clock).to eq(expected_number)
      end
    end
  end

  describe '#castle_info' do
    subject(:castle_fen) { described_class.new(fen_string, piece) }
    context 'when the fen string indicates all castling options are possible' do
      let(:fen_string) { 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1' }
      it 'returns a hash with the key:value of white_king_side: true' do
        expect(castle_fen.castle_info[:white_king_side]).to be(true)
      end

      it 'returns a hash with the key:value of white_king_side: true' do
        expect(castle_fen.castle_info[:white_queen_side]).to be(true)
      end

      it 'returns a hash with the key:value of black_king_side: true' do
        expect(castle_fen.castle_info[:black_king_side]).to be(true)
      end

      it 'returns a hash with the key:value of black_queen_side: true' do
        expect(castle_fen.castle_info[:black_queen_side]).to be(true)
      end
    end

    context 'when the fen string indicates no castling options are possible' do
      let(:fen_string) { 'rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPPKPPP/RNBQ1BNR b - - 1 2' }
      it 'returns a hash with the key:value of white_king_side: false' do
        expect(castle_fen.castle_info[:white_king_side]).to be(false)
      end

      it 'returns a hash with the key:value of white_king_side: false' do
        expect(castle_fen.castle_info[:white_queen_side]).to be(false)
      end

      it 'returns a hash with the key:value of black_king_side: false' do
        expect(castle_fen.castle_info[:black_king_side]).to be(false)
      end

      it 'returns a hash with the key:value of black_queen_side: false' do
        expect(castle_fen.castle_info[:black_queen_side]).to be(false)
      end
    end

    context 'when the fen string indicates black can castle king side and white can castle queen side' do
      let(:fen_string) { 'rn1qkb1r/ppp1pp1p/5np1/3p4/3P4/4PP1P/PPP2P2/RNBQKBR1 b Qk - 1 6' }
      it 'returns a hash with the key:value of white_king_side: false' do
        expect(castle_fen.castle_info[:white_king_side]).to be(false)
      end

      it 'returns a hash with the key:value of white_king_side: false' do
        expect(castle_fen.castle_info[:white_queen_side]).to be(true)
      end

      it 'returns a hash with the key:value of black_king_side: false' do
        expect(castle_fen.castle_info[:black_king_side]).to be(true)
      end

      it 'returns a hash with the key:value of black_queen_side: false' do
        expect(castle_fen.castle_info[:black_queen_side]).to be(false)
      end
    end
  end
end
