import 'package:flutter/material.dart';
import 'package:hangman_game/hangman/gamePage.dart';
import 'package:hangman_game/hangman/welcomePage.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/welcome',
      routes: {
        '/welcome' : (context) => WelcomePage(),
        '/easyGame' : (context) => GamePanel("Easy"),
        '/mediumGame' : (context) => GamePanel("Medium"),
        '/hardGame' : (context) => GamePanel("Hard"),
      },
    );
  }
}
