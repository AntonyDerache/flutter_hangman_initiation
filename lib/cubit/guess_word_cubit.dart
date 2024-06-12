import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/cubit/guess_word_state.dart';

class GuessWordCubit extends Cubit<GuessWordState> {
  GuessWordCubit() : super(GuessWordState(""));

  void setGuessWord(String newGuessWord) {
    emit(GuessWordState(newGuessWord));
  }
}
