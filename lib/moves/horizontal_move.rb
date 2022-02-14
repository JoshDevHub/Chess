# frozen_string_literal: true

# class for managing moves to left and right or an origin
class HorizontalMove < Move
  MOVESET = [
    %i[left],
    %i[right]
  ].freeze
end