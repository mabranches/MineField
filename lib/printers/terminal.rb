class Printer::Terminal < Printer
  def print_state
    print to_s
  end

  def to_s
    str = ""
    @row.times.each do |i|
      @col.times.each do |j|
        str << case
        when  @bombs && @bombs[i, j] == 1
          'B'
        when @flags[i, j] == 1
          'F'
        when @bomb_clicked == [i, j]
          'B'
        when @not_discovered[i, j] == 1
          '.'
        when @bombs_vinicity_state[[i, j]]
          @bombs_vinicity_state[[i, j]].to_s
        else
          'C'
        end
      end
      str << "\n"
    end
    str
  end
end
