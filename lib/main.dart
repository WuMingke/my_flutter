import 'package:flutter/material.dart';

import 'learncanvas/canvas1.dart';
import 'learnwidget/gesture_widget.dart';

void main() {
  // runApp(const LearnWidget());
  // WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  // SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(const LearnCanvas());
}

class LearnWidget extends StatelessWidget {
  const LearnWidget({super.key});

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
      // body: const TestPosition(),
      // body: const ContainerTest(),
      // body: const ContainerTest2(),
      // body: const ContainerTest3(),
      // body: const ScrollWidgetTest(),
      // body: const TestWillPop(),
      // body: const InheritedWidgetTestRoute(),
      // body: const TestFuture(),
      // body: const TestStream(),
      // body: const TestDialog(),
      // body: const TestGesture(),
      // body: const TestGesture2(),
      body: const Drag(),
    );
  }
}
