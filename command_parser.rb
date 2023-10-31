# frozen_string_literal: true

require 'English'

class CommandParser
  attr_reader :input_stream

  def initialize(input_stream, &)
    @input_stream = input_stream
    parse_stream(&)
  end

  protected

  def parse_stream(&)
    while (line = input_stream.gets)
      line.strip!
      # Ignore comments and blank lines
      next if line.start_with?('#') || line == ''

      parse_line(line, &)
    end
  end

  def parse_line(line, &)
    command, arguments = line.split(' ', 2)

    command = command.downcase.to_sym
    if command == :place
      x, y, facing = *arguments.split(',')
      yield command, x.to_i, y.to_i, facing.downcase
    else
      yield command
    end
  rescue StandardError
    warn "Error #{$ERROR_INFO} while parsing line: #{line.inspect}"
    warn $ERROR_INFO.backtrace
  end
end
