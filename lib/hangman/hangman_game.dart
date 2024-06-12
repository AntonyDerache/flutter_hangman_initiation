import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangman_game/hangman/history_counter.dart';
import 'package:hangman_game/cubit/guess_word_cubit.dart';
import 'package:hangman_game/cubit/guess_word_state.dart';
import 'package:hangman_game/hangman/dialogs/end_dialog.dart';
import 'package:hangman_game/hangman/dialogs/guess_word_dialog.dart';
import 'package:hangman_game/types/guess_enum.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key, required this.guessWord});

  final String guessWord;

  @override
  State<StatefulWidget> createState() => _HangmanGame();
}

class _HangmanGame extends State<HangmanGame> {
  final TextEditingController guessLetterController = TextEditingController();
  List<String> guessHistory = List.empty(growable: true);

  @override
  void dispose() {
    guessLetterController.dispose();
    super.dispose();
  }

  void hasReachMaximalAttempts() {
    if (guessHistory.length == 10) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return EndDialog(
              endWord: context.read<GuessWordCubit>().state.guessWord,
              isSuccess: false,
            );
          }).then((_) {
        context.read<GuessWordCubit>().reset();
      });
    }
  }

  void tryGuessLetter() {
    if (guessLetterController.text == '') return;
    String userInput = guessLetterController.text[0];

    guessLetterController.text = '';
    if (context.read<GuessWordCubit>().tryGuessLetter(userInput) ==
        GuessStateEnum.failed) {
      guessHistory.add(userInput);
      hasReachMaximalAttempts();
    }
    setState(() {/* The list guess history changed. */});
  }

  void tryGuessWord() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const GuessWordDialog();
        }).then((result) {
      if (result != null) {
        switch (context.read<GuessWordCubit>().tryGuessWord(result)) {
          case GuessStateEnum.wordFound:
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EndDialog(
                    endWord: context.read<GuessWordCubit>().state.guessWord,
                    isSuccess: true,
                  );
                }).then((_) {
              context.read<GuessWordCubit>().reset();
            });
            break;
          case GuessStateEnum.failed:
            guessHistory.add(result);
          default:
            break;
        }
      }
      setState(() {/* The list guess history changed. */});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: const Text("Hangman Game",
              style: TextStyle(color: Colors.indigo)),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Top part: Counter
              HistoryCounter(guessHistory: guessHistory),
              // Bottom part: User input
              Column(children: [
                // Hidden word
                BlocBuilder<GuessWordCubit, GuessWordState>(
                  builder: (context, state) {
                    return Text(state.hiddenWord,
                        style: const TextStyle(fontSize: 20));
                  },
                ),

                // Input for letters
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: guessLetterController,
                      maxLength: 1,
                      onSubmitted: (value) => tryGuessLetter(),
                      decoration: const InputDecoration(
                          counterText: "",
                          hintText: '...',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ),

                // Submit buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: tryGuessWord,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                        ),
                        child: const Text("Try guess word",
                            style: TextStyle(color: Colors.indigo))),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: tryGuessLetter,
                        child: const Text("Submit letter")),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => context.read<GuessWordCubit>().reset(),
                  child: const Text("Quit"),
                ),
              ])
            ],
          ),
        )));
  }
}
