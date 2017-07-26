#!/usr/bin/env ruby
require 'pry'

class Flip
  def initialize filename
    @filename = filename
    @output = ""
  end

  def generate_output
    cases.each_with_index do |case_item, idx|
      flips = 0
      case_item.each_with_index do |case_item_val, case_item_val_idx|

        if case_item_val == false
          case_item[case_item_val_idx..-1] = case_item[case_item_val_idx..-1].map { |w| !w }
          flips += 1
        end
      end
      @output << "Case ##{idx+1}: #{flips}\n"
    end

    File.open("#{@filename}.out", 'w') { |file| file.write(@output) }
  end

  def lines
    @lines ||= File.readlines(@filename).map do |line|
      line.strip.split('').map { |v| v == "+" }.reverse
    end
  end

  def cases
    lines[1..-1]
  end

  def case_count
    cases.count
  end
end

sheep = Flip.new("B-large.in")
sheep.generate_output
