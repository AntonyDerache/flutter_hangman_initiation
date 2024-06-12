class GuessWordState {
  String guessWord = '';
  String hiddenWord = '';

  GuessWordState(String newWord) {
    guessWord = newWord;
    hiddenWord = hiddenWord.padRight(guessWord.runes.length, ' _');
    if (guessWord.isNotEmpty) {
      hiddenWord =
          hiddenWord.substring(0, 0) + guessWord[0] + hiddenWord.substring(2);
    }
  }

  @override
  String toString() {
    return 'Word to guess: $guessWord';
  }
}
