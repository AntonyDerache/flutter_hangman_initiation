import 'package:flutter/material.dart';

class HistoryCounter extends StatelessWidget {
  const HistoryCounter({
    super.key,
    required this.guessHistory,
  });

  final List<String> guessHistory;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text("Lose counter"),
      Text(guessHistory.length.toString(),
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
