import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/cubit/cubit_observer.dart';
import 'package:hangman_game/cubit/guess_word_cubit.dart';
import 'package:hangman_game/cubit/guess_word_state.dart';
import 'package:hangman_game/hangman/hangman_game.dart';
import 'package:hangman_game/hangman/hangman_home.dart';

void main() {
  Bloc.observer = const CubitObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuessWordCubit(),
      child: MaterialApp(
        title: 'Hangman project',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5)),
                    elevation: 3))),
        home: BlocBuilder<GuessWordCubit, GuessWordState>(
          builder: (context, state) {
            if (state.guessWord == "") {
              return const HangmanHome();
            } else {
              return HangmanGame(guessWord: state.guessWord);
            }
          },
        ),
      ),
    );
  }
}
