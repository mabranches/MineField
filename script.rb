require './lib/mine_field.rb'
require './lib/printers.rb'
width, height, num_mines = 10, 20, 50
game = MineField.new(width, height, num_mines)

while game.still_playing?
  valid_move = game.play(rand(width), rand(height))
  valid_flag = game.flag(rand(width), rand(height))
  if valid_move or valid_flag
    printer = Printer::Terminal.new(game.board_state)
    printer.print_state
    puts
  end
end

puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  Printer::Terminal.new(game.board_state(xray: true)).print_state
end
