# frozen_string_literal: true

require_relative 'table'
require_relative 'errors'

class Robot
  DIRECTIONS = %i[north east south west].freeze

  attr_reader :x, :y, :facing, :max_x, :max_y

  # 0, 0 = SOUTH WEST CORNER
  def initialize(x, y, facing, max_x, max_y)
    @x = x
    @y = y
    @facing = facing.to_s.to_sym
    @max_x = max_x
    @max_y = max_y

    validate_facing
  end

  def move # rubocop:disable Metrics/CyclomaticComplexity
    case facing
    when :north
      @y += 1 if y + 1 <= max_y
    when :south
      @y -= 1 if y - 1 >= 0
    when :east
      @x += 1 if x + 1 <= max_x
    when :west
      @x -= 1 if x - 1 >= 0
    end
  end

  def left
    if current_face_idx.zero?
      @facing = :west
      return
    end

    @facing = DIRECTIONS[current_face_idx - 1]
  end

  def right
    if current_face_idx == 3
      @facing = :north
      return
    end

    @facing = DIRECTIONS[current_face_idx + 1]
  end

  def report
    puts inspect
  end

  def inspect
    "<#{self.class} id: #{object_id} x: #{x} y: #{y} facing: #{facing}>"
  end

  protected

  def current_face_idx
    DIRECTIONS.index(facing)
  end

  def validate_facing
    return if DIRECTIONS.include?(facing)

    raise InvalidRobotPositionError, "facing must be one of: #{DIRECTIONS.map(&:to_s).join(' ')}"
  end
end
