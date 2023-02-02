import 'package:flutter/material.dart';

void main() {
  runApp(
    const Align(
      alignment: Alignment.topLeft,
      child: ColoredBox(color: Colors.blue),
      // 这里 它的约束变成了 BoxConstraints(0.0<=w<=360.0, 0.0<=h<=741.3)
    ),
  );
}
