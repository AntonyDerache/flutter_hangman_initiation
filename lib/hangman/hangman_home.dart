import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/cubit/guess_word_cubit.dart';

class HangmanHome extends StatefulWidget {
  const HangmanHome({super.key});

  @override
  State<StatefulWidget> createState() => _HangmanHome();
}

class _HangmanHome extends State<HangmanHome> {
  final TextEditingController guessWordController = TextEditingController();

  @override
  void dispose() {
    guessWordController.dispose();
    super.dispose();
  }

  void submitGuessWord() {
    context.read<GuessWordCubit>().setGuessWord(guessWordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: const Text("Hangman Game"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter a guess word:"),
              const SizedBox(height: 20),
              TextField(controller: guessWordController),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => submitGuessWord(),
                  child: const Text("Submit")),
            ],
          ),
        )));
  }
}
