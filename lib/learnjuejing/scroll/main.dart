import 'package:flutter/material.dart';
import 'package:my_flutter/learnjuejing/scroll/scroll3.dart';

void main() {
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("123"),
        ),
        body: Scroll3(),
      ),
    );
  }
}
