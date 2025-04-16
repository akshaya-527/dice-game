import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(DiceGameApp());
}

class DiceGameApp extends StatelessWidget {
  const DiceGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Game',
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          primary: const Color(0xFF6366F1),
          secondary: const Color(0xFF4F46E5),
          surface: const Color(0xFFF8FAFC),
        ),
        useMaterial3: true,
      ),
      home: const DiceGameHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DiceGameHomePage extends StatefulWidget {
  const DiceGameHomePage({super.key});

  @override
  _DiceGameHomePageState createState() => _DiceGameHomePageState();
}

class _DiceGameHomePageState extends State<DiceGameHomePage> {
  int p1Dice = 6;
  int p2Dice = 6;
  String result = "The Dice Game";

  void rollDice() {
    setState(() {
      p1Dice = Random().nextInt(6) + 1;
      p2Dice = Random().nextInt(6) + 1;

      if (p1Dice > p2Dice) {
        result = "🚩 Player 1 wins!";
      } else if (p2Dice > p1Dice) {
        result = "Player 2 wins! 🚩";
      } else {
        result = "Draw!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      body: Center(
        child: Container(
          width: 800,
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                result,
                style: TextStyle(
                  fontSize: 42,
                  fontFamily: 'Shrikhand',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PlayerWidget(player: 'Player 1', diceValue: p1Dice),
                  PlayerWidget(player: 'Player 2', diceValue: p2Dice),
                ],
              ),
              const SizedBox(height: 48),
              FilledButton(
                onPressed: rollDice,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textStyle: const TextStyle(
                    fontFamily: 'Shrikhand',
                    fontSize: 22,
                    letterSpacing: 1,
                  ),
                ),
                child: const Text('ROLL DICE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String player;
  final int diceValue;

  const PlayerWidget({super.key, 
    required this.player,
    required this.diceValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          player,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Image.asset(
            'assets/dice$diceValue.png',
            width: 100,
          ),
        ),
      ],
    );
  }
}
