import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Stack(
        fit: StackFit.passthrough,
        children: const [
          SizedBox(
            width: 4000,
            height: 4000,
            child: ColoredBox(
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    ),
  );
}
