# frozen_string_literal: true

require_relative 'table'
require_relative 'command_parser'

# Initialize the playing field
table = Table.new(5, 5)

# Parse STDIN and invoke commands
CommandParser.new($stdin) do |command, *arguments|
  if command == :place
    table.place_robot(*arguments)
  elsif table.robot_placed?
    if table.robot.respond_to?(command)
      table.robot.send(command)
    else
      warn "Unknown robot command: #{command}"
    end
  end
end
