import 'dart:math';

import 'package:hangman_game/words/word.dart';

class WordChooser{

  static List<Word> easyWords = [
    Word(word: "apple", hint: "A common fruit with red or green skin."),
    Word(word: "happy", hint: "An emotion associated with joy and contentment."),
    Word(word: "house", hint: "A place where people live."),
    Word(word: "bird", hint: "A flying creature with feathers."),
    Word(word: "table", hint: "A piece of furniture used for eating or working."),
    Word(word: "smile", hint: "A facial expression indicating happiness."),
    Word(word: "green", hint: "The color of grass and leaves."),
    Word(word: "water", hint: "A transparent liquid essential for life."),
    Word(word: "music", hint: "Artistic sounds organized in a harmonious way."),
    Word(word: "sleep", hint: "A natural state of rest for the body and mind.")
  ];

  static List<Word> mediumWords = [
    Word(word: "elephant", hint: "A large, gray mammal with a trunk."),
    Word(word: "jungle", hint: "A dense, tropical forest."),
    Word(word: "computer", hint: "An electronic device for processing data."),
    Word(word: "mountain", hint: "A large landform that rises prominently above its surroundings."),
    Word(word: "umbrella", hint: "A device used for protection against rain or sunlight."),
    Word(word: "camera", hint: "A device for capturing still or moving images."),
    Word(word: "oxygen", hint: "A vital element necessary for breathing."),
    Word(word: "guitar", hint: "A stringed musical instrument."),
    Word(word: "volcano", hint: "A mountain that can erupt with lava and ash."),
    Word(word: "puzzle", hint: "A game or problem designed to test ingenuity or knowledge.")
  ];

  static List<Word> hardWords = [
    Word(word: "exquisite", hint: "Extremely beautiful and, typically, delicate."),
    Word(word: "ephemeral", hint: "Lasting for a very short time."),
    Word(word: "serendipity", hint: "The occurrence and development of events by chance in a happy or beneficial way."),
    Word(word: "mnemonic", hint: "A memory aid or device."),
    Word(word: "quixotic", hint: "Extremely idealistic, unrealistic, and impractical."),
    Word(word: "juxtapose", hint: "To place or deal with close together for contrasting effect."),
    Word(word: "obfuscate", hint: "To deliberately make something unclear or difficult to understand."),
    Word(word: "vicissitude", hint: "A change of circumstances or fortune, typically one that is unwelcome or unpleasant."),
    // Word(word: "perspicacious", hint: "Having a ready insight into and understanding of things."),
    // Word(word: "sesquipedalian", hint: "Characterized by long words; long-winded.")
  ];

  static Word easyWord(){
    Random random = Random();
    return easyWords[random.nextInt(easyWords.length)];
  }

  static Word mediumWord(){
    Random random = Random();
    return mediumWords[random.nextInt(mediumWords.length)];
  }

  static Word hardWord(){
    Random random = Random();
    return hardWords[random.nextInt(hardWords.length)];
  }
}