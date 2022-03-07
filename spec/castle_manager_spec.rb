# frozen_string_literal: true

require_relative '../lib/castle_manager'

describe CastleManager do
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
        let(:castle_opts) do
          {
            white_king_side: true,
            white_queen_side: true,
            black_king_side: true,
            black_queen_side: true
          }
        end
        subject(:castle_manager) { described_class.new(castle_options: castle_opts) }
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
        let(:castle_opts) do
          {
            white_king_side: true,
            white_queen_side: false,
            black_king_side: false,
            black_queen_side: true
          }
        end
        subject(:castle_manager) { described_class.new(castle_options: castle_opts) }
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

  describe '#remove_castle_option' do
    context 'when the chosen option is initially true' do
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: true,
          black_queen_side: true
        }
      end
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

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
      let(:castle_opts) do
        {
          white_king_side: false,
          white_queen_side: false,
          black_king_side: false,
          black_queen_side: false
        }
      end
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }

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
      let(:castle_opts) do
        {
          white_king_side: true,
          white_queen_side: true,
          black_king_side: true,
          black_queen_side: true
        }
      end
      subject(:castle_manager) { described_class.new(castle_options: castle_opts) }
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
end
