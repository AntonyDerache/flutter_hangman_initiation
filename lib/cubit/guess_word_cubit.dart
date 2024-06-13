import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/cubit/guess_word_state.dart';
import 'package:hangman_game/types/guess_enum.dart';
import 'package:hangman_game/utils/replace_char_at.dart';

class GuessWordCubit extends Cubit<GuessWordState> {
  GuessWordCubit() : super(GuessWordState(""));

  void setGuessWord(String newGuessWord) {
    emit(GuessWordState(newGuessWord));
  }

  GuessStateEnum tryGuessLetter(String userInput) {
    List<int> occurenceIndexes = List.empty(growable: true);
    int userInputAsChar = userInput.toLowerCase().runes.first;
    List<int> guessWordCharacters =
        state.guessWord.toLowerCase().runes.toList();

    for (int i = 0; i < guessWordCharacters.length; i++) {
      if (guessWordCharacters[i] == userInputAsChar) {
        occurenceIndexes.add(i);
      }
    }
    if (occurenceIndexes.isNotEmpty) {
      for (int elem in occurenceIndexes) {
        state.hiddenWord = ReplaceCharAt.call(
            state.hiddenWord, elem * 2, state.guessWord[elem]);
      }
      emit(state);
      if (!state.hiddenWord.contains('_')) {
        return GuessStateEnum.wordFound;
      }
      return GuessStateEnum.letterFound;
    }
    return GuessStateEnum.failed;
  }

  GuessStateEnum tryGuessWord(String userInput) {
    if (userInput.toLowerCase() == state.guessWord.toLowerCase()) {
      state.hiddenWord = state.guessWord;
      emit(state);
      return GuessStateEnum.wordFound;
    }
    return GuessStateEnum.failed;
  }

  void reset() {
    emit(GuessWordState(''));
  }
}
