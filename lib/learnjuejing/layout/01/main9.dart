import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            color: Colors.blue,
            width: 100000,
            height: 100,
          ),
        ],
      ),
    ),
  );
}
