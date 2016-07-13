require './lib/bit_set_simple.rb'
class Board < Delegator

  BIT_SET_KLASS = BitSetSimple

  attr_accessor :row, :col, :table
  def initialize(row, col)
    @row = row
    @col = col
    @table = BIT_SET_KLASS.new(row * col)
  end

  def __getobj__
    @table
  end

  def []=(i, j, value)
    @table[pos(i, j)] = value
  end

  def [](i, j)
    @table[pos(i, j)]
  end

  def print
    table_str = @table.to_s

    (0..(@row - 1)).each do |i|
      puts table_str[(@col * i)..(@col * i + @col-1)]
    end
  end

  def loop_neighbors(i,j)
    (-1..1).each do |k1|
      (-1..1).each do |k2|
        if (k1 != 0 || k2 != 0) && (0..@row-1).include?(i + k1) &&
          (0..@col-1).include?(j + k2)
          yield(i + k1, j + k2)
        end
      end
    end
  end

  private
    def pos(i,j)
      i * @col + j
    end
end
