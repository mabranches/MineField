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

  private
    def start_list
      '<table>'
    end

    def end_list
      '</table>'
    end

    def start_line
      '<tr>'
    end

    def end_line
      '</tr>'
    end

    def start_cell
      '<td>'
    end

    def end_cell
      '</td>'
    end
end
