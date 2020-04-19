require 'colorize'
require_relative 'lib/console_interface'
require_relative 'lib/game'


puts "Всем привет!"

word = File.readlines("#{__dir__}/data/words.txt", chomp: true).sample


game = Game.new(word.chomp)
console_interface = ConsoleInterface.new(game)


until game.over? # пока не закончилась игра
  # вывести очередное состояние игры
  console_interface.print_out
  # спросить очередную букву
  letter = console_interface.get_input
  # обновить сосотояние игры
  game.play!(letter)
end

console_interface.print_out


