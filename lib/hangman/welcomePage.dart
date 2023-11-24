import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman_game/hangman/gamePage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],

      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                padding: EdgeInsets.all(30),

                child: Column(
                  children: [
                    Text("Welcome To", style: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.w600)),
                    Text("HANGMAN", style: TextStyle(color: Colors.grey[700] , fontSize: 50, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Column(
                children: [
                  Text("Choose Difficulty To Start Game",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: 50,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChooseDifficultyButton(difficulty: "Easy"),
                    SizedBox(height: 15,),
                    ChooseDifficultyButton(difficulty: "Medium"),
                    SizedBox(height: 15,),
                    ChooseDifficultyButton(difficulty: "Hard"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseDifficultyButton extends StatelessWidget {

  String difficulty;

  ChooseDifficultyButton({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, "/${difficulty.toLowerCase()}Game");
        },
        child: Text(difficulty, style: TextStyle(fontSize: 30)),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
        shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(12))
      ),
    );
  }
}

