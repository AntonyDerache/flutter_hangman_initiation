class GuessWordState {
  String guessWord = '';
  String hiddenWord = '';

  GuessWordState(String newWord) {
    guessWord = newWord;
    // TODO - initialiser hiddenWord (ex: Toto = T _ _ _)
  }

  @override
  String toString() {
    return 'Word to guess: $guessWord';
  }
}
