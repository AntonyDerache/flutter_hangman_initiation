import 'package:flutter/material.dart';

class EndDialog extends StatelessWidget {
  const EndDialog({super.key, required this.endWord, required this.isSuccess});

  final String endWord;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isSuccess ? 'Congrats !' : 'Try again!'),
      content: Text('The word was $endWord'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(isSuccess ? 'Back to home' : 'Retry'),
        ),
      ],
    );
  }
}
