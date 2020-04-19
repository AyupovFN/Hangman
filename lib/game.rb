
class Game
  MAX_ERRORS = 7
  def initialize(word)
    @letters = word.chars
    @normalized_letters = normalized_letters(word.chars)
    @user_guesses = normalized_letters([])
  end

  def errors
    @user_guesses - @normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    MAX_ERRORS - errors_made
  end

  def letters_to_guess
    result = @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      else
        nil
      end
    end
  end

  def normalized_letters(word_for_normalize)
    result = word_for_normalize.map do |letter|
      normalize_letter(letter)
    end
  end

  def normalize_letter(letter)
    return 'Е' if letter == 'Ё'
    return 'И' if letter == 'Й'

    letter
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

  def word
    @letters.join
  end

  def won?
    (@normalized_letters - @user_guesses).empty?
  end

  def lost?
    errors_allowed.zero?
  end
end
