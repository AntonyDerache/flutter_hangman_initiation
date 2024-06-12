import 'package:flutter/material.dart';
import 'package:hangman_game/example/example_click_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman project',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const ClickCounter(title: 'Hangman Game'),
    );
  }
}
