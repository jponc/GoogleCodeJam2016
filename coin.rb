#!/usr/bin/env ruby

require 'prime'
require 'timeout'
require 'pry'

class Coin
  def initialize filename
    @filename = filename
    @output = ""
  end

  def generate_output
    cases.each_with_index do |case_item, idx|
      @output << "Case ##{idx+1}:\n"
      generate_case_output(case_item)
    end

    File.open("#{@filename}.out", 'w') { |file| file.write(@output) }
  end

  def generate_case_output case_item
    n, j = case_item
    val = 1
    hits = 0
    hit_values = []

    loop do
      inner_binary = ("%b" % val).rjust(n-2, "0")
      new_jam_coin = "1#{inner_binary}1"
      puts "Value: #{val}"
      invalid = (2..10).any? do |x|
        begin
          Timeout::timeout(1) { Prime.prime? new_jam_coin.to_i(x) }
        rescue
          true
        end
      end

      unless invalid
        hit_values << new_jam_coin
        puts "Hits count: #{hits}/#{j}"
        hits +=1
      end

      if hits == j
        break
      else
        val += 1
      end
    end

    hit_values.each do |hit_value|
      base_values = (2..10).map { |x| hit_value.to_i(x) } 
      divisors = 
        base_values.map do |base_value|
          divisor = 2
          loop do
            if (base_value % divisor) == 0
              break
            else
              divisor += 1
            end
          end
          divisor
        end
      @output << "#{hit_value} #{divisors.join(' ')}\n"
    end
  end

  def lines
    @lines ||= File.readlines(@filename).map do |line|
      line.strip.split(' ').map(&:to_i)
    end
  end

  def cases
    lines[1..-1]
  end

  def case_count
    cases.count
  end
end

sheep = Coin.new("C-large.in")
sheep.generate_output
