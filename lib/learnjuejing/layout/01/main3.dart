import 'package:flutter/material.dart';

void main() {
  runApp(
    const UnconstrainedBox(
      child: SizedBox(width: 100, height: 100, child: ColoredBox(color: Colors.blue)),
    ),
  );
}
