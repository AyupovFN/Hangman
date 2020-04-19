
class ConsoleInterface

  FIGURES =
      Dir[__dir__+'/../data/figures/*.txt'].
      sort.map { |file_name| File.read(file_name) }

  COLOR_LATTER = [:green, :blue, :white, :red, :yellow]

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show.colorize(COLOR_LATTER.sample)}
      #{figure.colorize(:yellow)}
      #{"Ошибки (#{@game.errors_made}): #{errors_to_show}".colorize(:red)}
      #{"У вас осталось ошибок:".colorize(:green)} #{@game.errors_allowed.to_s.black.on_yellow.blink}

    END

    if @game.won?
      puts "#{"Поздравляю вы выграли!".colorize(COLOR_LATTER.sample)}"
    elsif @game.lost?
      puts "вы проиграли, загадоное слово: #{@game.word}"
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter.nil?
         "__"
        else
          letter
        end
      end

    result.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def get_input
    print "#{"Введите следующую букву:".colorize(:blue)}"
    letter = gets[0].capitalize
    return letter
  end

end
