import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/cubit/guess_word_state.dart';
import 'package:hangman_game/types/guess_enum.dart';
import 'package:hangman_game/utils/string_utils.dart';

class GuessWordCubit extends Cubit<GuessWordState> {
  final int nbrOfRounds;

  GuessWordCubit({this.nbrOfRounds = 10}) : super(const GuessWordState(''));

  void setGuessWord(String newGuessWord) {
    emit(GuessWordState.init(newGuessWord));
  }

  void tryGuessLetter(String userInput) {
    List<int> occurenceIndexes = List.empty(growable: true);
    int userInputAsChar = userInput.toLowerCase().runes.first;
    List<int> guessWordCharacters = state.guessWord.toLowerCase().runes.toList();

    occurenceIndexes = guessWordCharacters
        .asMap()
        .entries
        .where((entry) => entry.value == userInputAsChar)
        .map((entry) => entry.key)
        .toList();

    if (occurenceIndexes.isNotEmpty) {
      String hiddenWord = state.hiddenWord;
      for (final elem in occurenceIndexes) {
        hiddenWord = StringUtils.replaceCharAt(hiddenWord, elem * 2, state.guessWord[elem]);
      }
      final hasFoundWord = !hiddenWord.contains('_');
      emit(state.copyWith(
          hiddenWord: hiddenWord, guessState: hasFoundWord ? GuessStateEnum.wordFound : GuessStateEnum.letterFound));
    } else {
      final guessHistory = List<String>.from(state.guessHistory)..add(userInput);
      final hasLose = guessHistory.length == nbrOfRounds;
      emit(
        state.copyWith(
          guessState: hasLose ? GuessStateEnum.lose : GuessStateEnum.failed,
          guessHistory: guessHistory,
        ),
      );
    }
  }

  void tryGuessWord(String userInput) {
    if (userInput.toLowerCase() == state.guessWord.toLowerCase()) {
      emit(state.copyWith(guessState: GuessStateEnum.wordFound, hiddenWord: state.guessWord));
    } else {
      emit(state.copyWith(guessState: GuessStateEnum.failed));
    }
  }

  void reset() {
    emit(const GuessWordState(''));
  }
}
