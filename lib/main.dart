import 'package:flutter/material.dart';
import 'package:my_flutter/learnwidget/layout_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: "123",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      int a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: const TextTest(),
      // body: const ButtonTest(),
      // body: const ImageTest(),
      // body: const TestCheckBox(),
      // body: const TextFieldTest(),
      // body: const FocusTestRoute(),
      // body: const FormTestRoute(),
      // body: const TestProgress(),
      // body: const ProgressRoute(),
      // body: const TestLayout(),
      // body: const FlexLayoutTestRoute(),
      body: const TestPosition(),
    );
  }
}
