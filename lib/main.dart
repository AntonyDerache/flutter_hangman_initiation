import 'package:flutter/material.dart';
import 'package:hangman_game/example_click_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hangman project',
      home: ClickCounter(title: 'Hangman Game'),
    );
  }
}
