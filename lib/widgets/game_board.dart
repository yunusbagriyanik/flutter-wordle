import 'package:flutter/material.dart';

import '../utils/game_provider.dart';

class GameBoard extends StatefulWidget {
  const GameBoard(this.game, {super.key});

  final WorldeGame game;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.game.wordleBoard
          .map(
            (row) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: row
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 64.0,
                      height: 64.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: e.code == 0
                            ? Colors.grey.shade800
                            : e.code == 1
                            ? Colors.green.shade400
                            : Colors.amber.shade400,
                      ),
                      child: Center(
                        child: Text(
                          e.letter ?? "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
