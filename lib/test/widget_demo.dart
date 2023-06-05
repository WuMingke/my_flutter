import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("123"),
        ),
        body: Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FlutterLogo(),
              SizedBox(
                width: 100,
                height: 10,
              ),
              FlutterLogo(),
            ],
          ),
        ),
      ),
    );
  }
}
