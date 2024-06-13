import 'package:equatable/equatable.dart';
import 'package:hangman_game/types/guess_enum.dart';

class GuessWordState extends Equatable {
  final String guessWord;
  final String hiddenWord;

  final GuessStateEnum guessState;
  final List<String> guessHistory;

  final int guessMaxAttempt;

  const GuessWordState(
    this.guessWord, {
    this.hiddenWord = '',
    this.guessState = GuessStateEnum.failed,
    this.guessHistory = const [],
    this.guessMaxAttempt = 10,
  });

  GuessWordState.init(this.guessWord, {this.guessMaxAttempt = 10})
      : assert(guessWord.isNotEmpty, 'Word to guess cannot be empty'),
        hiddenWord = guessWord[0] + ''.padRight(guessWord.runes.length, ' _').substring(2),
        guessState = GuessStateEnum.failed,
        guessHistory = const [];

  @override
  String toString() {
    return 'Word to guess: $guessWord';
  }

  GuessWordState copyWith({
    String? guessWord,
    String? hiddenWord,
    GuessStateEnum? guessState,
    List<String>? guessHistory,
  }) {
    return GuessWordState(
      guessWord ?? this.guessWord,
      hiddenWord: hiddenWord ?? this.hiddenWord,
      guessState: guessState ?? this.guessState,
      guessHistory: guessHistory ?? this.guessHistory,
    );
  }

  @override
  List<Object?> get props => [guessWord, hiddenWord, guessState, guessHistory];
}
