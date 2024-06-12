import 'package:flutter/material.dart';

class GuessWordDialog extends StatelessWidget {
  const GuessWordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController guessWordController = TextEditingController();

    return AlertDialog(
      title: const Text('Guess the word!'),
      content: TextField(
        controller: guessWordController,
        decoration: const InputDecoration(hintText: "Ex: kayak"),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, guessWordController.text);
          },
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}
