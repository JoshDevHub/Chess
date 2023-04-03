# frozen_string_literal: true

RSpec.describe Coordinate do
  subject(:coordinate_includer) { Class.new { extend Coordinate } }

  describe '#to_square_notation' do
    context 'when the x,y coordinate is [0, 0]' do
      it 'returns A8' do
        coordinate = [0, 0]
        square = 'A8'
        expect(coordinate_includer.to_square_notation(coordinate)).to eq(square)
      end
    end

    context 'when the x,y coordinate is [5, 3]' do
      it 'returns F5' do
        coordinate = [5, 3]
        square = 'F5'
        expect(coordinate_includer.to_square_notation(coordinate)).to eq(square)
      end
    end

    context 'when the x,y coordinate is [2, 7]' do
      it 'returns C1' do
        coordinate = [2, 7]
        square = 'C1'
        expect(coordinate_includer.to_square_notation(coordinate)).to eq(square)
      end
    end
  end

  describe '#to_xy_coordinate' do
    context 'when the square is A0' do
      it 'returns [0, 7]' do
        square = 'A1'
        coordinate = [0, 7]
        expect(coordinate_includer.to_xy_coordinate(square)).to eq(coordinate)
      end
    end

    context 'when the square is E4' do
      it 'returns [4, 4]' do
        square = 'E4'
        coordinate = [4, 4]
        expect(coordinate_includer.to_xy_coordinate(square)).to eq(coordinate)
      end
    end
  end

  describe '#valid_square?' do
    context 'when the square is valid' do
      it 'returns true for square A1' do
        square = 'A1'
        expect(coordinate_includer.valid_square?(square)).to be(true)
      end

      it 'returns true for F8' do
        square = 'F8'
        expect(coordinate_includer.valid_square?(square)).to be(true)
      end

      it 'returns true for C2' do
        square = 'C2'
        expect(coordinate_includer.valid_square?(square)).to be(true)
      end
    end

    context 'when the square is invalid' do
      it 'returns false for B9' do
        square = 'B9'
        expect(coordinate_includer.valid_square?(square)).to be(false)
      end

      it 'returns false for I3' do
        square = 'I3'
        expect(coordinate_includer.valid_square?(square)).to be(false)
      end

      it 'returns false for D42' do
        square = 'D42'
        expect(coordinate_includer.valid_square?(square)).to be(false)
      end
    end
  end

  describe '#up' do
    context 'when the target square is valid' do
      it 'returns the target square' do
        square = 'E2'
        target_square = 'E3'
        expect(coordinate_includer.up(square)).to eq(target_square)
      end
    end

    context 'when the target square is invalid' do
      it 'returns the target square' do
        square = 'B9'
        target_square = 'B10'
        expect(coordinate_includer.up(square)).to eq(target_square)
      end
    end
  end

  describe '#down' do
    context 'when the target square is valid' do
      it 'returns the target square' do
        square = 'A8'
        target_square = 'A7'
        expect(coordinate_includer.down(square)).to eq(target_square)
      end
    end

    context 'when the target square is invalid' do
      it 'returns the target square' do
        square = 'E1'
        target_square = 'E0'
        expect(coordinate_includer.down(square)).to eq(target_square)
      end
    end
  end

  describe '#right' do
    context 'when the target square is valid' do
      it 'returns the target square' do
        square = 'D4'
        target_square = 'E4'
        expect(coordinate_includer.right(square)).to eq(target_square)
      end
    end

    context 'when the target square is invalid' do
      it 'returns the target square' do
        square = 'H7'
        target_square = 'I7'
        expect(coordinate_includer.right(square)).to eq(target_square)
      end
    end
  end

  describe '#left' do
    context 'when the target square is valid' do
      it 'returns the target square' do
        square = 'H6'
        target_square = 'G6'
        expect(coordinate_includer.left(square)).to eq(target_square)
      end
    end

    context 'when the target square is invalid' do
      it 'returns the target square' do
        square = 'A3'
        target_square = '@3'
        expect(coordinate_includer.left(square)).to eq(target_square)
      end
    end
  end
end
