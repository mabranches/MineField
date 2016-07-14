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
end
require './lib/printers/terminal.rb'
