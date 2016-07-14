require 'byebug'
require './lib/board.rb'
class MineField
  S_POINT = Struct.new(:i, :j)
  MASK_ROW = (1 << 3) -1 #11
  attr_accessor :bombs, :clicked, :flags, :bomb_clicked, :bombs_in_vinicity
  def initialize(row, col, n_bombs)
    @row = row
    @col = col
    @n_bombs = n_bombs
    @flags = Board.new(row, col)
    @clicked = Board.new(row, col)
    @bombs = initialize_bomb_board
    @bombs_in_vinicity = initialize_bombs_in_vinicity
    @won = true
    @bomb_clicked = nil
  end

  def finished?
    !@bomb_clicked.nil? || (@clicked | @bombs).all_set?
  end

  def won?
    @won if finished?
  end

  def flag(i, j)
    @flags[i, j] = 1
  end

  def play(i, j)
    if @clicked[i, j] == 1 || @flags[i, j] == 1 ||
      !valid_point?(i, j)
      return false
    end

    if bombs[i, j] == 1
      clicked[i, j] = 1
      @bomb_clicked = [i, j]
      @won = false
      return true
    end

    propagate_discovery(i, j)
    return true
  end

  #private
  def propagate_discovery(i, j)#point?
    return if @bombs[i, j] == 1 || @clicked[i, j] == 1
    @clicked[i, j] = 1
    return if has_bombs?(i, j)
    @bombs.loop_neighbors(i, j) do |x, y|
      propagate_discovery(x, y)
    end
  end

  def has_bombs?(i,j)
    point = S_POINT.new(i, j)
    block_mask = get_block_mask(point)
    !(bombs & block_mask).all_clear?
  end

  def get_block_mask(point)
    line_mask = get_line_mask(point)
    block_mask = 0
    (-1..1).each do |pos|
      shift_line = point.i + pos
      next if shift_line < 0
      block_mask |= line_mask << shift_line * @col
    end
    block_mask
  end

  def get_line_mask(point)
    mask = get_base_mask(point)
    mask << [0, point.j - 1].max
  end

  def get_base_mask(point)
    mask = MASK_ROW
    mask >>= 1 if on_border?(point)
    mask
  end

  def on_border?(point)
    point.j == @col -1 || point.j == 0
  end

  def valid_point?(i, j)
    i >= 0 && i < @row &&
    j >= 0 && j < @col
  end

  def initialize_bomb_board
    board = Board.new(@row, @col)
    board.set_random(@n_bombs)
    board
  end

  #O(8CR)
  def initialize_bombs_in_vinicity
    bombs_in_vinicity = []
    @row.times do
      bombs_in_vinicity << Array.new(@col, 0)
    end
    @row.times.each do |i|
      @col.times.each do |j|
        next if @bombs[i, j] == 0
        @bombs.loop_neighbors(i, j) do |x, y|
          bombs_in_vinicity[x][y] += 1
        end
      end
    end
    bombs_in_vinicity
  end
end
