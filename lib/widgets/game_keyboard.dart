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
  final List<String> row1 = "QWERTYUIOPĞÜ".split("");
  final List<String> row2 = "ASDFGHJKLŞİ".split("");
  final List<String> row3 = [
    "DEL",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
    "Ö",
    "Ç",
    "SUBMIT",
  ];

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
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: _buildKey(
                  label: e,
                  onTap: () {
                    if (WorldeGame.gameOver) return;

                    if (widget.game.letterId < 5) {
                      widget.game.insertWord(
                        widget.game.letterId,
                        Letter(e, 0),
                      );
                      widget.game.letterId++;
                      setState(() {});
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map((e) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: _buildKey(
                  label: e,
                  onTap: () {
                    if (WorldeGame.gameOver) return;

                    if (widget.game.letterId < 5) {
                      widget.game.insertWord(
                        widget.game.letterId,
                        Letter(e, 0),
                      );
                      widget.game.letterId++;
                      setState(() {});
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map((e) {
            final bool isWide = e == "DEL" || e == "SUBMIT";
            final String displayLabel = e == "DEL"
                ? "←"
                : (e == "SUBMIT" ? "⏎" : e);

            return Expanded(
              flex: isWide ? 2 : 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: _buildKey(
                  label: displayLabel,
                  onTap: () {
                    if (WorldeGame.gameOver) return;

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
                      _handleSubmit();
                    } else {
                      if (widget.game.letterId < 5) {
                        widget.game.insertWord(
                          widget.game.letterId,
                          Letter(e, 0),
                        );
                        widget.game.letterId++;
                        setState(() {});
                      }
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (widget.game.letterId < 5) return;

    String guess = widget.game.wordleBoard[widget.game.rowId]
        .map((l) => l.letter)
        .join();

    if (widget.game.checkWordExist(guess)) {
      setState(() {
        WorldeGame.game_message = "";
      });

      if (guess == WorldeGame.game_guess) {
        setState(() {
          WorldeGame.game_message = "Tebrikler! 🎉";
          widget.game.wordleBoard[widget.game.rowId].forEach((element) {
            element.code = 1;
          });
          WorldeGame.gameOver = true;
        });
        _showGameOverSheet(isWin: true);
      } else {
        int listLength = guess.length;
        for (int i = 0; i < listLength; i++) {
          String char = guess[i].toUpperCase();
          if (WorldeGame.game_guess.contains(char)) {
            if (WorldeGame.game_guess[i] == char) {
              setState(() {
                widget.game.wordleBoard[widget.game.rowId][i].code = 1;
              });
            } else {
              setState(() {
                widget.game.wordleBoard[widget.game.rowId][i].code = 2;
              });
            }
          }
        }

        widget.game.rowId++;
        widget.game.letterId = 0;

        if (widget.game.rowId >= widget.game.wordleBoard.length) {
          setState(() {
            WorldeGame.game_message =
                "Oyun Bitti! Cevap: ${WorldeGame.game_guess} 🎉";
            WorldeGame.gameOver = true;
          });
          _showGameOverSheet(isWin: false);
        }
      }
    } else {
      setState(() {
        WorldeGame.game_message = "Böyle bir kelime yok, tekrar dene 😉";
      });
    }
  }

  void _showGameOverSheet({required bool isWin}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2B2B2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isWin ? "Tebrikler! 🎉" : "Oyun bitti",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Kelime: ${WorldeGame.game_guess}",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB3E5FC),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      widget.game.resetGame();
                    });
                  },
                  child: const Text(
                    "Yeni oyun",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Kapat",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKey({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.shade300,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
