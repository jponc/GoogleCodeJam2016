#!/usr/bin/env ruby

require 'pry'
class Sheep
  def initialize filename
    @filename = filename
    @output = ""
  end

  def generate_output
    cases.each_with_index do |case_item, idx|
      out = "INSOMNIA"
      if case_item > 0
        n = 1
        data_hash = {}

        loop do
          val = (case_item * n).to_s
          val.split('').each { |v| data_hash[v] = true }
          if data_hash.count == 10
            out = val
            break
          else
            n += 1
          end

        end
      end
      @output << "Case ##{idx+1}: #{out}\n"
    end

    File.open("#{@filename}.out", 'w') { |file| file.write(@output) }
  end

  def lines
    @lines ||= File.readlines(@filename).map do |line|
      line.strip.to_i
    end
  end

  def cases
    lines[1..-1]
  end

  def case_count
    cases.count
  end
end

sheep = Sheep.new("A-large.in")
sheep.generate_output
