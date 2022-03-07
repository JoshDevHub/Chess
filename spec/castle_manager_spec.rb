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
end
