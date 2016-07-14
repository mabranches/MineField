class Printer

  def print_state
    print to_s
  end

  def initialize(state)
    @row = state[:row]
    @col = state[:col]
    @bombs = state[:bombs]
    @not_discovered = state[:not_discovered]
    @flags = state[:flags]
    @bombs_vinicity_state = state[:bombs_vinicity_state]
    @bomb_clicked  = state[:bomb_clicked]
  end

  def to_s
    str = start_list
    @row.times.each do |i|
      str << start_line
      @col.times.each do |j|
        str<< start_cell
        str << case
        when  @bombs && @bombs[i, j] == 1
          'M'
        when @flags[i, j] == 1
          'F'
        when @bomb_clicked == [i, j]
          'M'
        when @not_discovered[i, j] == 1
          '.'
        when @bombs_vinicity_state[[i, j]]
          @bombs_vinicity_state[[i, j]].to_s
        else
          'C'
        end
        str << end_cell
      end
      str << end_line
    end
    str << end_list
    str
  end

  private
    def method_missing(m)
      ''
    end

end
require './lib/printers/terminal.rb'
require './lib/printers/html.rb'
