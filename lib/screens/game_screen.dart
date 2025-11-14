import 'package:flutter/material.dart';

import '../utils/game_provider.dart';
import '../widgets/game_keyboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final WorldeGame _game = WorldeGame();

  @override
  void initState() {
    super.initState();
    _game.resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              "🧩 Kelimeyi çöz! 6 hakkın var. 🔥",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: GameKeyboard(_game)),
          ],
        ),
      ),
    );
  }
}
