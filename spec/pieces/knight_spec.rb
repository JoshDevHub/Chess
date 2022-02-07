# frozen_string_literal: true

require_relative '../../lib/piece'
require_relative '../../lib/pieces/knight'

describe Knight do
  subject(:knight) { described_class.new(color: 'black') }
  describe '#knight_moves?' do
    it 'returns true' do
      expect(knight.knight_moves?).to be(true)
    end
  end
end
