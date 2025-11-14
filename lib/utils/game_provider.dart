import 'dart:math';

class WorldeGame {
  int rowId = 0;
  int letterId = 0;

  static String game_message = "";
  static String game_guess = "";
  static List<String> word_list = [
    "world",
    "fight",
    "brain",
    "plane",
    "earth",
    "robot",
    "",
  ];
  static bool gameOver = false;

  static List<Letter> wordleRow = List.generate(5, (index) => Letter("", 0));
  List<List<Letter>> wordleBoard = List.generate(
    5,
    (index) => List.generate(5, (index) => Letter("", 0)),
  );

  void passTry() {
    rowId++;
    letterId = 0;
  }

  static void initGame() {
    final random = Random();
    String selected = "";

    while (selected.trim().isEmpty) {
      int index = random.nextInt(word_list.length);
      selected = word_list[index];
    }

    game_guess = selected.toUpperCase();
  }

  void resetGame() {
    rowId = 0;
    letterId = 0;
    game_message = "";
    gameOver = false;

    wordleBoard = List.generate(
      5,
      (index) => List.generate(5, (index) => Letter("", 0)),
    );

    initGame();
  }

  void insertWord(int index, Letter word) {
    wordleBoard[rowId][index] = word;
  }

  bool checkWordExist(String word) {
    return word_list.contains(word);
  }
}

class Letter {
  String? letter;
  int code = 0;

  Letter(this.letter, this.code);
}
