import 'package:flutter/material.dart';

void main() {
  // runApp(const ColoredBox(color: Colors.blue));

  runApp(MaterialApp(
    home: Container(
      width: 100,
      height: 100,
      child: ColoredBox(color: Colors.red),
    ),
  ));
}
