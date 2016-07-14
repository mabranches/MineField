class Printer::Terminal < Printer
  def print_state
    row = @state[:row]
    col = @state[:col]
    bombs = @state[:bombs]
    not_discovered = @state[:not_discovered]
    flags = @state[:flags]
    bombs_vinicity_state = @state[:bombs_vinicity_state]
    bomb_clicked  = @state[:bomb_clicked]
    row.times.each do |i|
      col.times.each do |j|
        case
        when  bombs && bombs[i, j] == 1
          print 'B'
        when flags[i, j] == 1
          print 'F'
        when bomb_clicked == [i, j]
          print 'B'
        when not_discovered[i, j] == 1
          print '.'
        when bombs_vinicity_state[[i, j]]
          print bombs_vinicity_state[[i, j]]
        else
          print 'C'
        end
      end
      puts
    end
  end
end
