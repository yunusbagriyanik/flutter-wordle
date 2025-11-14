import 'dart:math';

import 'package:characters/characters.dart';

class WorldeGame {
  int rowId = 0;
  int letterId = 0;

  static String game_message = "";
  static String game_guess = "";

  static List<String> word_list = [
    "abone",
    "acıma",
    "adres",
    "afişe",
    "ahenk",
    "ailem",
    "akşam",
    "akide",
    "alaka",
    "alıcı",
    "alkış",
    "almak",
    "ambar",
    "amber",
    "anket",
    "anlık",
    "arama",
    "arıza",
    "arzum",
    "aslen",
    "asmak",
    "aşama",
    "atmak",
    "aygıt",
    "aymaz",
    "azami",
    "azlık",
    "babam",
    "bacak",
    "bakım",
    "balık",
    "banka",
    "basit",
    "başka",
    "bayan",
    "belge",
    "belki",
    "benim",
    "beton",
    "birim",
    "bilgi",
    "bilet",
    "borsa",
    "boyut",
    "buzlu",
    "çağrı",
    "cahil",
    "çanta",
    "çevre",
    "çıkar",
    "çimen",
    "çorap",
    "deren",
    "derin",
    "dünya",
    "duvar",
    "efsun",
    "eğmek",
    "eklem",
    "ekmek",
    "elmas",
    "emlak",
    "evlat",
    "fazıl",
    "fikir",
    "filiz",
    "fizik",
    "fiyat",
    "fişek",
    "kalem",
    "kalıp",
    "kanat",
    "kanun",
    "kapak",
  ];

  static bool gameOver = false;

  static List<Letter> wordleRow = List.generate(5, (index) => Letter("", 0));
  List<List<Letter>> wordleBoard = List.generate(
    5,
    (index) => List.generate(5, (index) => Letter("", 0)),
  );

  static String toUpperTr(String input) {
    return input.replaceAll('i', 'İ').replaceAll('ı', 'I').toUpperCase();
  }

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

    game_guess = toUpperTr(selected);
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
    String upper = toUpperTr(word);
    return word_list.any((w) => toUpperTr(w) == upper);
  }

  String normalize(String input) {
    return input.characters.toString();
  }
}

class Letter {
  String? letter;
  int code = 0;

  Letter(this.letter, this.code);
}
