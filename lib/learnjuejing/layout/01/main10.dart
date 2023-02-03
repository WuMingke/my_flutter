import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: LoopLayout(),
    ),
  );
}

class LoopLayout extends StatelessWidget {
  const LoopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: ColoredBox(
            color: Colors.blue,
          ),
        ),
        Expanded(
            child: ColoredBox(
          color: Colors.blue,
        )),
        Container(
          height: 10,
        )
      ],
    );
  }
}
