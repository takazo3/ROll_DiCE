import 'dart:math';
import 'package:flutter/material.dart';
import 'package:roll_dice/styled_text.dart';

final randamizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState(); //
  }
}

class _DiceRollerState extends State<DiceRoller> with SingleTickerProviderStateMixin {
  var currentDice = 1;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void rollDice() {
    setState(() {
      _controller.reset();
      _controller.forward();
    });
    
    // 2秒間シャッフル
    for (int i = 0; i < 20; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        setState(() {
          currentDice = randamizer.nextInt(6) + 1;
        });
      });
    }
    
    // 最終的な結果を設定
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        currentDice = randamizer.nextInt(6) + 1;
      });
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.8 + (_animation.value * 0.2),
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/dice-$currentDice.png',
            width: 200,
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(foregroundColor: Colors.pink),
          child: StyledText("Press to Roll it!"),
        ),
      ],
    );
  }
}
