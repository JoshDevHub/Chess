# frozen_string_literal: true

RSpec.describe WhitePawn do
  subject(:white_pawn) { described_class.new(color: 'white', position: square) }

  let(:board) { instance_double(Board) }

  describe '#move_list' do
    let(:double_up_instance) { instance_double(WhitePawnDoubleAdvance) }
    let(:diagonal_capture) { instance_double(WhitePawnCapture) }
    let(:one_up) { instance_double(WhitePawnAdvance) }

    context 'when the piece is off the 2nd rank' do
      let(:square) { 'B5' }

      before do
        allow(WhitePawnAdvance).to receive(:new).and_return(one_up)
        allow(WhitePawnCapture).to receive(:new).and_return(diagonal_capture)

        allow(one_up).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of WhitePawnAdvance' do
        white_pawn.move_list(board)
        expect(WhitePawnAdvance).to have_received(:new)
      end

      it 'sends #generate_moves to the WhitePawnAdvance instance' do
        white_pawn.move_list(board)
        expect(one_up).to have_received(:generate_moves)
      end

      it 'instantiates an instance of WhitePawnCapture' do
        white_pawn.move_list(board)
        expect(WhitePawnCapture).to have_received(:new)
      end

      it 'sends #generate_moves to the WhitePawnCapture instance' do
        white_pawn.move_list(board)
        expect(diagonal_capture).to have_received(:generate_moves)
      end

      it 'does not instantiate an instance of WhitePawnDoubleAdvance' do
        expect(WhitePawnDoubleAdvance).not_to receive(:new)
        white_pawn.move_list(board)
      end
    end

    context 'when the piece is on the 2nd rank' do
      let(:square) { 'E2' }

      before do
        allow(WhitePawnAdvance).to receive(:new).and_return(one_up)
        allow(WhitePawnCapture).to receive(:new).and_return(diagonal_capture)
        allow(WhitePawnDoubleAdvance).to receive(:new).and_return(double_up_instance)

        allow(one_up).to receive(:generate_moves).and_return([])
        allow(diagonal_capture).to receive(:generate_moves).and_return([])
        allow(double_up_instance).to receive(:generate_moves).and_return([])
      end

      it 'instantiates an instance of WhitePawnAdvance' do
        white_pawn.move_list(board)
        expect(WhitePawnAdvance).to have_received(:new)
      end

      it 'sends #generate_moves to the WhitePawnAdvance instance' do
        white_pawn.move_list(board)
        expect(one_up).to have_received(:generate_moves)
      end

      it 'instantiates an instance of WhitePawnCapture' do
        white_pawn.move_list(board)
        expect(WhitePawnCapture).to have_received(:new)
      end

      it 'sends #generate_moves to the WhitePawnCapture instance' do
        white_pawn.move_list(board)
        expect(diagonal_capture).to have_received(:generate_moves)
      end

      it 'instantiates an instance of WhitePawnDoubleAdvance' do
        white_pawn.move_list(board)
        expect(WhitePawnDoubleAdvance).to have_received(:new)
      end

      it 'sends #generate_moves to the WhitePawnDoubleAdvance instance' do
        white_pawn.move_list(board)
        expect(double_up_instance).to have_received(:generate_moves)
      end
    end
  end

  describe '#define_en_passant_square' do
    context 'when the passed in move indicates a normal pawn move' do
      let(:square) { 'F5' }
      let(:target) { 'F6' }

      it 'returns nil' do
        expect(white_pawn.define_en_passant_square(target)).to be_nil
      end
    end

    context 'when the passed in move indicates a capture move' do
      let(:square) { 'E2' }
      let(:target) { 'D3' }

      it 'returns nil' do
        expect(white_pawn.define_en_passant_square(target)).to be_nil
      end
    end

    context 'when the passed in move indicates a double move' do
      let(:square) { 'B2' }
      let(:target) { 'B4' }
      let(:en_passant) { 'B3' }

      it 'returns the position above the origin' do
        expect(white_pawn.define_en_passant_square(target)).to eq(en_passant)
      end
    end
  end

  describe '#capture_en_passant?' do
    let(:square) { 'B5' }

    context 'when the given square is not an en passant square for white' do
      context 'when the given square is nil' do
        let(:given_square) { nil }

        it 'returns nil or false' do
          expect(white_pawn.capture_en_passant?(given_square)).to be_falsey
        end
      end

      context 'when the square is not nil' do
        let(:given_square) { 'B7' }
        let(:given_square) { 'B3' }
        let(:given_square) { 'B3' }

        it 'returns nil or false' do
          expect(white_pawn.capture_en_passant?(given_square)).to be_falsey
        end

        it 'returns nil or false' do
          expect(white_pawn.capture_en_passant?(given_square)).to be_falsey
        end
      end
    end

    context 'when the given square is an en passant square for white' do
      let(:given_square) { 'A6' }

      it 'returns true' do
        expect(white_pawn.capture_en_passant?(given_square)).to be(true)
      end
    end
  end

  describe '#can_promote?' do
    context 'when the pawn cannot promote' do
      context 'when the white pawn is on C4' do
        let(:square) { 'C4' }

        it 'returns false' do
          expect(white_pawn.can_promote?).to be(false)
        end
      end

      context 'when the pawn is on F2' do
        let(:square) { 'F2' }

        it 'returns false' do
          expect(white_pawn.can_promote?).to be(false)
        end
      end
    end

    context 'when the pawn can promote' do
      context 'when the white pawn is on C8' do
        let(:square) { 'C8' }

        it 'returns true' do
          expect(white_pawn.can_promote?).to be(true)
        end
      end

      context 'when teh pawn is on F8' do
        let(:square) { 'F8' }

        it 'returns true' do
          expect(white_pawn.can_promote?).to be(true)
        end
      end
    end
  end

  describe '#move_resets_clock?' do
    let(:square) { 'E2' }

    it 'returns true' do
      expect(white_pawn.move_resets_clock?).to be(true)
    end
  end

  describe '#to_fen' do
    let(:square) { 'E2' }

    it "returns the string 'P'" do
      expected_string = 'P'
      expect(white_pawn.to_fen).to eq(expected_string)
    end
  end
end
