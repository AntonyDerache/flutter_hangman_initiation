import 'package:flutter/material.dart';

class HistoryCounter extends StatelessWidget {
  const HistoryCounter(
      {super.key, required this.guessHistory, this.maxAttempt = 10});

  final List<String> guessHistory;
  final int maxAttempt;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text("Remaining attempts"),
      Text((maxAttempt - guessHistory.length).toString(),
          style: const TextStyle(fontSize: 30)),
      Wrap(
        spacing: 5,
        direction: Axis.horizontal,
        children: guessHistory.map((item) {
          return Text(item);
        }).toList(),
      ),
    ]);
  }
}