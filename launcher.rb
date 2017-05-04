#!/usr/bin/env ruby

require_relative "processor"

filename = ARGV[0]
processor = Processor.new(filename)
processor.run
processor.print_output
