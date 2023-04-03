# frozen_string_literal: true

RSpec.describe CastleManager do
  describe '#can_castle?' do
    context 'when the manager is initialized with default options' do
      subject(:castle_manager) { described_class.new }

      context 'when the color to check is white' do
        let(:color) { :white }

        context 'when the side to check is king side' do
          let(:side) { :king }

          it 'returns false' do
            expect(castle_manager.can_castle?(color, side)).to be(false)
          end
        end

        context 'when the side to check is queen side' do
          let(:side) { :queen }

          it 'returns false' do
            expect(castle_manager.can_castle?(color, side)).to be(false)
          end
        end
      end

      context 'when the color to check is black' do
        let(:color) { 'black' }

        context 'when the side to check is king side' do
          let(:side) { 'king' }

          it 'returns false' do
            expect(castle_manager.can_castle?(color, side)).to be(false)
          end
        end

        context 'when the side to check is queen side' do
          let(:side) { :queen }

          it 'returns false' do
            expect(castle_manager.can_castle?(color, side)).to be(false)
          end
        end
      end
    end

    context 'when the manager is initialized with a hash' do
      context 'when the hash says all castling options are possible' do
        subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

        let(:castle_opts) do
          {
            white_king_side: true,
            white_queen_side: true,
            black_king_side: true,
            black_queen_side: true
          }
        end

        context 'when the color to check is white' do
          let(:color) { :white }

          context 'when the side to check is king side' do
            let(:side) { :king }

            it 'returns true' do
              expect(castle_manager.can_castle?(color, side)).to be(true)
            end
          end

          context 'when the side to check is queen side' do
            let(:side) { :queen }

            it 'returns true' do
              expect(castle_manager.can_castle?(color, side)).to be(true)
            end
          end
        end

        context 'when the color to check is black' do
          let(:color) { 'black' }

          context 'when the side to check is king side' do
            let(:side) { 'king' }

            it 'returns true' do
              expect(castle_manager.can_castle?(color, side)).to be(true)
            end
          end

          context 'when the side to check is queen side' do
            let(:side) { :queen }

            it 'returns true' do
              expect(castle_manager.can_castle?(color, side)).to be(true)
            end
          end
        end
      end

      context 'when the hash indicates white can castle kingside and black can castle queenside' do
        subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

        let(:castle_opts) do
          {
            white_king_side: true,
            white_queen_side: false,
            black_king_side: false,
            black_queen_side: true
          }
        end

        context 'when the color to check is white' do
          let(:color) { :white }

          context 'when the side to check is king side' do
            let(:side) { :king }

            it 'returns true' do
              expect(castle_manager.can_castle?(color, side)).to be(true)
            end
          end

          context 'when the side to check is queen side' do
            let(:side) { :queen }

            it 'returns false' do
              expect(castle_manager.can_castle?(color, side)).to be(false)
            end
          end
        end

        context 'when the color to check is black' do
          let(:color) { 'black' }

          context 'when the side to check is king side' do
            let(:side) { 'king' }

            it 'returns false' do
              expect(castle_manager.can_castle?(color, side)).to be(false)
            end
          end

          context 'when the side to check is queen side' do
            let(:side) { :queen }

            it 'returns true' do
              expect(castle_manager.can_castle?(color, side)).to be(true)
            end
          end
        end
      end
    end
  end

  describe '#castle_rights_for_color?' do
    subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

    context 'when both colors can castle to at least one side' do
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: false,
          black_queen_side: true
        }
      end

      context 'when the given color is white' do
        it 'returns true' do
          expect(castle_manager.castle_rights_for_color?('white')).to be(true)
        end
      end

      context 'when the given color is black' do
        it 'returns true' do
          expect(castle_manager.castle_rights_for_color?('black')).to be(true)
        end
      end
    end

    context 'when one color can castle and the other cannot' do
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: false,
          black_king_side: false,
          black_queen_side: false
        }
      end

      context 'when the given color is white' do
        it 'returns true' do
          expect(castle_manager.castle_rights_for_color?('white')).to be(true)
        end
      end

      context 'when the given color is black' do
        it 'returns false' do
          expect(castle_manager.castle_rights_for_color?('black')).to be(false)
        end
      end
    end

    context 'when neither color can castle' do
      let(:castle_opts) do
        {
          white_king_side: false,
          white_queen_side: false,
          black_king_side: false,
          black_queen_side: false
        }
      end

      context 'when the given color is white' do
        it 'returns false' do
          expect(castle_manager.castle_rights_for_color?('white')).to be(false)
        end
      end

      context 'when the given color is black' do
        it 'returns false' do
          expect(castle_manager.castle_rights_for_color?('black')).to be(false)
        end
      end
    end
  end

  describe '#remove_castle_option' do
    context 'when the chosen option is initially true' do
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: true,
          black_queen_side: true
        }
      end

      context 'when the given option is a white color and king side' do
        it 'changes the key :white_king_side to false' do
          expected_options = {
            white_king_side: false,
            white_queen_side: true,
            black_king_side: true,
            black_queen_side: true
          }
          castle_manager.remove_castle_option('white', :king)
          instance_options = castle_manager.instance_variable_get(:@castle_options)
          expect(instance_options).to eq(expected_options)
        end
      end
    end

    context 'when the chosen option is initially false' do
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

      let(:castle_opts) do
        {
          white_king_side: false,
          white_queen_side: false,
          black_king_side: false,
          black_queen_side: false
        }
      end

      context 'when the given option is black color and queen side' do
        it 'does not change the key :black_queen_side' do
          expected_options = {
            white_king_side: false,
            white_queen_side: false,
            black_king_side: false,
            black_queen_side: false
          }
          castle_manager.remove_castle_option('black', :queen)
          instance_options = castle_manager.instance_variable_get(:@castle_options)
          expect(instance_options).to eq(expected_options)
        end
      end
    end
  end

  describe '#remove_all_castles_for_color' do
    context 'when the color is initially able to castle' do
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: true,
          black_queen_side: true
        }
      end

      context 'when the color is white' do
        let(:color) { 'white' }

        it 'changes white_king_side in castle options to false' do
          key_to_check = :white_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true).to(false)
        end

        it 'changes white_queen_side in castle options to false' do
          key_to_check = :white_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true).to(false)
        end

        it 'does not change black_king_side in castle options to false' do
          key_to_check = :black_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end

        it 'does not change black_queen_side in castle options to false' do
          key_to_check = :black_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end
      end

      context 'when the color is black' do
        let(:color) { 'black' }

        it 'changes black_king_side in castle options to false' do
          key_to_check = :black_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true).to(false)
        end

        it 'changes black_queen_side in castle options to false' do
          key_to_check = :black_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true).to(false)
        end

        it 'does not change white_king_side in castle options to false' do
          key_to_check = :white_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end

        it 'does not change white_queen_side in castle options to false' do
          key_to_check = :white_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end
      end
    end

    context 'when the color cannot castle and the other color can castle' do
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

      context 'when the color is white' do
        let(:castle_opts) do
          {
            white_king_side: false,
            white_queen_side: false,
            black_king_side: true,
            black_queen_side: true
          }
        end
        let(:color) { 'white' }

        it 'does not change white_king_side in castle options from false' do
          key_to_check = :white_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(false)
        end

        it 'does not change white_queen_side in castle options from false' do
          key_to_check = :white_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(false)
        end

        it 'does not change black_king_side in castle options from true' do
          key_to_check = :black_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end

        it 'does not change black_queen_side in castle options to true' do
          key_to_check = :black_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end
      end

      context 'when the color is black' do
        let(:color) { 'black' }
        let(:castle_opts) do
          {
            white_king_side: true,
            white_queen_side: true,
            black_king_side: false,
            black_queen_side: false
          }
        end

        it 'does not change black_king_side in castle options from false' do
          key_to_check = :black_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(false)
        end

        it 'does not change black_queen_side in castle options from false' do
          key_to_check = :black_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(false)
        end

        it 'does not change white_king_side in castle options from true' do
          key_to_check = :white_king_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end

        it 'does not change white_queen_side in castle options to true' do
          key_to_check = :white_queen_side
          expect { castle_manager.remove_all_castles_for_color(color) }
            .not_to change { castle_manager.instance_variable_get(:@castle_options)[key_to_check] }
            .from(true)
        end
      end
    end
  end

  describe '#handle_castling' do
    subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

    let(:castle_opts) do
      {
        white_king_side: true,
        white_queen_side: true,
        black_king_side: false,
        black_queen_side: false
      }
    end
    let(:board) { instance_double(Board) }
    let(:piece) { instance_double(Piece) }
    let(:target) { 'C1' }

    context 'when the move being executed is a castling move' do
      before do
        allow(piece).to receive(:castle_move?).and_return(true)
        allow(board).to receive(:move_piece)
        allow(piece).to receive(:disable_castle_rights)
      end

      it 'sends #castle_move? with target to the given piece' do
        castle_manager.handle_castling(piece, target, board)
        expect(piece).to have_received(:castle_move?).with(target)
      end

      it 'sends #move_piece to the board with the coordinates of a rook to move' do
        expected_origin = 'A1'
        expected_target = 'D1'
        expect(board).to receive(:move_piece).with(expected_origin, expected_target)
        castle_manager.handle_castling(piece, target, board)
      end

      it 'sends #disable_castle_rights to the piece' do
        castle_manager.handle_castling(piece, target, board)
        expect(piece).to have_received(:disable_castle_rights)
      end
    end

    context 'when the move being executed is not a castling move' do
      before do
        allow(piece).to receive(:castle_move?).and_return(false)
        allow(piece).to receive(:disable_castle_rights)
      end

      it 'sends #castle_move? with target to the given piece' do
        castle_manager.handle_castling(piece, target, board)
        expect(piece).to have_received(:castle_move?).with(target)
      end

      it 'sends #disable_castle_rights to the piece' do
        castle_manager.handle_castling(piece, target, board)
        expect(piece).to have_received(:disable_castle_rights)
      end

      it 'does not send #move_piece to the board' do
        expect(board).not_to receive(:move_piece)
        castle_manager.handle_castling(piece, target, board)
      end
    end
  end

  describe '#to_fen' do
    subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

    context 'when all castling options are possible' do
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: true,
          black_queen_side: true
        }
      end

      it "returns the string 'KQkq'" do
        expected_string = 'KQkq'
        expect(castle_manager.to_fen).to eq(expected_string)
      end
    end

    context 'when black cannot castle at all' do
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: false,
          black_queen_side: false
        }
      end

      it "returns the string 'KQ'" do
        expected_string = 'KQ'
        expect(castle_manager.to_fen).to eq(expected_string)
      end
    end

    context 'when neither color can castle queen side' do
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: false,
          black_king_side: true,
          black_queen_side: false
        }
      end

      it "returns the string 'Kk'" do
        expected_string = 'Kk'
        expect(castle_manager.to_fen).to eq(expected_string)
      end
    end

    context 'when no castling is possible' do
      let(:castle_opts) do
        {
          white_king_side: false,
          white_queen_side: false,
          black_king_side: false,
          black_queen_side: false
        }
      end

      it "returns the string '-'" do
        expected_string = '-'
        expect(castle_manager.to_fen).to eq(expected_string)
      end
    end
  end
end
