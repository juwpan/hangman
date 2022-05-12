class Game
# Количество допустимых ошибок
  TOTAL_ERRORS_ALLOWED = 7

# Конструктор класса Game на вход получает строку с загаданным словом.
#
# В конструкторе инициализируем две переменные экземпляра: массив букв
# загаданного слова и пустой массив для дальнейшего сбора в него вводимых
# букв.
  def initialize(word)
    @letters = word.upcase.chars
    @user_guesses = []
  end

# Возвращает массив букв, введенных пользователем, но отсутствующих в
# загаданном слове (ошибочные буквы)
  def errors
    @user_guesses - normalized_letters
  end

# Возвращает количество ошибок, сделанных пользователем
  def errors_made
    errors.length
  end

# Отнимает от допустимого количества ошибок число сделанных ошибок и
# возвращает оставшееся число допустимых ошибок
  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

# Возвращает массив с уже отгаданными буквами, вместо неотгаданных букв в
# массиве на соответствующем месте находится nil. Этот массив нужен методу
# экземпляра класса ConsoleInterface для вывода слова на игровом табло.
  def letters_to_guess
    @letters.map do |letter|
      if @user_guesses.include?(normalize_letter(letter))
        letter
      end
    end
  end

# Возвращает true, если у пользователя не осталось ошибок, т.е. игра проиграна
  def lost?
    errors_allowed == 0
  end

# Нормализует буквы Ё и Й в Е и И
  def normalize_letter(letter)
    case letter
    when 'Ё'
      'Е'
    when 'Й'
      'И'
    else
      letter
    end
  end

# Преобразует буквы в слове Ё => Е и Й => И
  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

# Возвращает true, если игра закончена (проиграна или выиграна)
  def over?
    won? || lost?
  end

# По сути, это основной игровой метод, типа "сыграть букву".
#
# Если игра не закончена и передаваемая буква отсутствует в массиве
# введённых букв, то закидывает передаваемую букву в массив "попыток".
  def play!(letter)
    if !over? && !@user_guesses.include?(normalize_letter(letter))
      @user_guesses << normalize_letter(letter)
    end
  end

# Возвращает true, если не осталось неотгаданных букв (пользователь выиграл)
  def won?
    (normalized_letters - @user_guesses).empty?
  end

# Возвращает загаданное слово, склеивая его из загаданных букв
  def word
    @letters.join
  end
end
