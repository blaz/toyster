# frozen_string_literal: true

require 'English'
require_relative 'errors'

class Table
  attr_reader :height, :width, :robot

  def initialize(height, width)
    @height = height
    @width = width
  end

  def place_robot(x, y, facing)
    unless valid_position?(x, y)
      warn "Robot not placed: invalid position (#{x}, #{y}) on #{height} x #{width}"
      return
    end

    # Placing creates a new robot instance
    @robot = Robot.new(x, y, facing, height - 1, width - 1)
  rescue InvalidRobotPositionError
    warn "Robot not placed: #{$ERROR_INFO}"
  end

  def robot_placed?
    !!robot
  end

  protected

  def valid_position?(x, y)
    return false unless x.is_a?(Integer) && x >= 0 && x < height
    return false unless y.is_a?(Integer) && y >= 0 && y < width

    true
  end
end
