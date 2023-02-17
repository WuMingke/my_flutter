import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          width: 100,
          color: Colors.blue,
          height: 100,
          child: ColoredBox(color: Colors.red),
        )
      ],
    ),
  ));
}
