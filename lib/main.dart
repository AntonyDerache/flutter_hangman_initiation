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
    return MaterialApp(
      title: 'Hangman project',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.5),
            ),
            elevation: 3,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => GuessWordCubit(),
        child: BlocBuilder<GuessWordCubit, GuessWordState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade100,
              title: const Text("Hangman Game"),
              centerTitle: true,
            ),
            body: state.guessWord.isEmpty ? const HangmanHome() : const HangmanGame(),
          ),
        ),
      ),
    );
  }
}
