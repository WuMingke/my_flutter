import 'package:flutter/material.dart';

import 'list_test.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("mooc"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: const GridViewTest(),
      ),
    );
  }
}
