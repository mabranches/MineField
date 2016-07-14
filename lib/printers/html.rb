class Printer::Html < Printer

  def legend
    %Q[
      <table>
      <th><td>Symbol</td><td>Meaning</td></th>
      <tr><td>C</td><td>Clear space</td></tr>
      <tr><td>F</td><td>Flag</td></tr>
      <tr><td>M</td><td>Mine</td></tr>
      <tr><td>.</td><td>Undiscovered</td></tr>
      <tr><td>Number</td><td>Number of mines around cel</td></tr>
      </table>
    ]
  end

  def to_s
    str = "<table>"
    @row.times.each do |i|
      str << "<tr>"
      @col.times.each do |j|
        str<<"<td>"
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
        str << "</td>"
      end
      str << "</tr>"
    end
    str"</table>"
    str
  end
end
