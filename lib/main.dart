import 'package:flutter/material.dart';
import 'package:roll_dice/gradient_container.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          body: GradientContainer(
        const Color.fromRGBO(33, 5, 109, 10),
        Color.fromRGBO(68, 21, 149, 10),
      )),
    ),
  );
}

