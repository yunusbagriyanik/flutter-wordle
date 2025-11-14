import 'package:flutter/material.dart';

import '../utils/game_provider.dart';
import 'game_board.dart';

class GameKeyboard extends StatefulWidget {
  const GameKeyboard(this.game, {super.key});

  final WorldeGame game;

  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List<String> row1 = "QWERTYUIOP".split("");
  List<String> row2 = "ASDFGHJKL".split("");
  List<String> row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          WorldeGame.game_message,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 20.0),
        GameBoard(widget.game),
        const SizedBox(height: 40.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.map((e) {
            return InkWell(
              onTap: () {
                if (WorldeGame.gameOver) {
                  setState(() {
                    widget.game.resetGame();
                  });
                  return;
                }

                if (widget.game.letterId < 5) {
                  widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                  widget.game.letterId++;
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map((e) {
            return InkWell(
              onTap: () {
                if (WorldeGame.gameOver) {
                  setState(() {
                    widget.game.resetGame();
                  });
                  return;
                }

                if (widget.game.letterId < 5) {
                  widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                  widget.game.letterId++;
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map((e) {
            return InkWell(
              onTap: () {
                if (WorldeGame.gameOver) {
                  setState(() {
                    widget.game.resetGame();
                  });
                  return;
                }

                if (e == "DEL") {
                  if (widget.game.letterId > 0) {
                    setState(() {
                      widget.game.insertWord(
                        widget.game.letterId - 1,
                        Letter("", 0),
                      );
                      widget.game.letterId--;
                    });
                  }
                } else if (e == "SUBMIT") {
                  if (widget.game.letterId >= 5) {
                    String guess = widget.game.wordleBoard[widget.game.rowId]
                        .map((l) => l.letter)
                        .join();

                    if (widget.game.checkWordExist(guess.toLowerCase())) {
                      if (guess == WorldeGame.game_guess) {
                        setState(() {
                          WorldeGame.game_message = "Congratulations🎉";
                          widget.game.wordleBoard[widget.game.rowId].forEach((
                            element,
                          ) {
                            element.code = 1;
                          });
                          WorldeGame.gameOver = true;
                        });
                      } else {
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++) {
                          String char = guess[i].toUpperCase();
                          if (WorldeGame.game_guess.contains(char)) {
                            if (WorldeGame.game_guess[i] == char) {
                              setState(() {
                                widget
                                        .game
                                        .wordleBoard[widget.game.rowId][i]
                                        .code =
                                    1;
                              });
                            } else {
                              setState(() {
                                widget
                                        .game
                                        .wordleBoard[widget.game.rowId][i]
                                        .code =
                                    2;
                              });
                            }
                          }
                        }

                        widget.game.rowId++;
                        widget.game.letterId = 0;

                        if (widget.game.rowId >=
                            widget.game.wordleBoard.length) {
                          setState(() {
                            WorldeGame.game_message =
                                "Game Over! Answer: ${WorldeGame.game_guess}";
                            WorldeGame.gameOver = true;
                          });
                        }
                      }
                    } else {
                      setState(() {
                        WorldeGame.game_message =
                            "the world does not exist try again";
                      });
                    }
                  }
                } else {
                  if (widget.game.letterId < 5) {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
