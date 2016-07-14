class Printer::Terminal < Printer

  def legend
    %Q[
      C : Clear space
      F : Flag
      M : Mine
      . : Undiscovered
      Number : Number of mines around cel
    ]
  end

  def end_line
    "\n"
  end

end
