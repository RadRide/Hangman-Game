import 'package:flutter/material.dart';
import 'package:hangman_game/hangman/game.dart';
import 'package:hangman_game/words/word.dart';
import 'package:hangman_game/words/wordChooser.dart';
import 'package:flash/flash.dart';

class GamePanel extends StatefulWidget {

  String difficulty;

  GamePanel(this.difficulty);

  @override
  State<GamePanel> createState() => _GamePanelState(difficulty);
}

class _GamePanelState extends State<GamePanel> {

  String difficulty;
  Word word = Word(word: "", hint: "");
  int mistakes = 0;

  List<String> images = [
    "assets/images/pic1.png",
    "assets/images/pic2.png",
    "assets/images/pic3.png",
    "assets/images/pic4.png",
    "assets/images/pic5.png",
    "assets/images/pic6.png",
    "assets/images/pic7.png",
  ];

  List<String> letters = [
    "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
  ];

  List<String> typedCharacters = [];
  List<Widget> letterBoxes = [];
  List<Widget> keyboard = [];

  _GamePanelState(this.difficulty);

  void changePic(){
    if(mistakes >= 6){
      gamePopup("Game Over", "You Lost");
    }else{
      mistakes++;
    }
  }

  /// Generates a word depending on the chosen difficulty
  Word generateWord(){
    switch (difficulty){
      case "Easy" : return WordChooser.easyWord();
      case "Medium" : return WordChooser.mediumWord();
      case "Hard" : return WordChooser.hardWord();
      default : return Word(word: "", hint: "");
    }
  }

  void showHint(){
    // Fluttertoast.showToast(
    //   msg: word.hint,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 5,
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    //   webBgColor: "#0f0f0f",
    //   webPosition: "left",
    //   webShowClose: true
    // );
    showFlash(
        context: context,
        duration: const Duration(seconds: 5),
        builder: (context, controller) => FlashBar(
            controller: controller,
            content: Text(word.hint),
          behavior: FlashBehavior.floating,
        )
    );
  }

  @override
  void initState() {
    super.initState();
    startGame();
    print("${word.word} - ${word.hint}");
  }

  void initLetterBoxes(){
    letterBoxes = word.word.split("").map((character) =>
        letter(character.toUpperCase(),
            !typedCharacters.contains(character.toUpperCase()))).toList();
  }

  void initKeyboard(){
    keyboard.clear();
    keyboard = letters.map((letter) =>
        KeyboardButton(letter: letter, onPressed: (){keyPressed(letter);}, key: UniqueKey(),)).toList();
  }


  void startGame(){
    mistakes = 0;
    word = generateWord();
    typedCharacters.clear();
    initLetterBoxes();
    initKeyboard();
  }

  /// Checks if the pressed letter is available in the word and shows their positions
  void keyPressed(String letter){
    if(!typedCharacters.contains(letter)){
      setState(() {
        typedCharacters.add(letter);
        print(typedCharacters);
        initLetterBoxes();
        if(!word.word.contains(letter.toLowerCase())){
          changePic();
        }
      });
    }

    if(isWordGuessed()){
      gamePopup("Congratulations!!", "You Guessed The Word");
    }
  }
  
  void gamePopup(String title, String message){
    showDialog(
        context: context,
        builder: (content) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: EdgeInsets.only(top: 20),
            backgroundColor: Colors.black,
            title: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 30),),
            content: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(message,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),),
                  Column(
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red[700],
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10)
                        ),
                          onPressed: (){
                            setState(() {
                              Navigator.pop(context);
                              startGame();
                            });
                          },
                          icon: Icon(Icons.refresh_sharp),
                          label: Text("Play Again")),
                      SizedBox(height: 15,),
                      TextButton.icon(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.menu),
                          label: Text("Main Menu"))
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  /// Checks if the all the characters are guessed
  bool isWordGuessed(){
    for(String character in word.word.split("")){
      if(!typedCharacters.contains(character.toUpperCase())){
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Game Panel $difficulty"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){setState(() {
                  startGame();
                });}, icon: Icon(Icons.refresh_sharp, color: Colors.white,)),
                IconButton(onPressed: (){showHint();}, icon: Icon(Icons.help_outline_rounded, color: Colors.white,))
              ],
            ),
            Image.asset(images[mistakes], height: 200, width: 300,),
            SizedBox(height: 20,),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: letterBoxes
            ),
            SizedBox(height: 20,),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: keyboard
            ),
          ],
        ),
      ),
    );
  }
}

Widget letter(String character, bool visible){
  return Container(
    height: 55,
    width: 50,
    padding: EdgeInsets.all(1),
    decoration: BoxDecoration(
      color: Colors.black54,
      borderRadius:  BorderRadius.circular(10),
    ),
    child: Center(
      child: Visibility(
        visible: !visible,
          child: Text(character,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          )
      ),
    ),
  );
}

class KeyboardButton extends StatefulWidget {
  KeyboardButton({
    super.key,
    required this.letter,
    required this.onPressed
  });

  String letter;
  Function onPressed;

  @override
  State<KeyboardButton> createState() => _KeyboardButtonState(letter, onPressed);
}

class _KeyboardButtonState extends State<KeyboardButton> {

  _KeyboardButtonState(this.letter, this.onPressed);

  String letter;
  Function onPressed;
  Color backColor = Colors.black;
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            onPressed();
            backColor = Colors.white;
            textColor = Colors.black;
          });
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          backgroundColor: backColor
        ),
        child: Text(letter, style: TextStyle(fontSize: 20, color: textColor),)
    );
  }
}
