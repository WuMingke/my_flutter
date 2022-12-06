import 'dart:async';

import 'package:flutter/material.dart';

class DemoWidget extends StatelessWidget {
  // String text = "";

  const DemoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          color: Colors.blue,
          child: const Text(
            "StatelessWidget",
            textDirection: TextDirection.ltr,
            // style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}

class SimpleFutureBuilder extends StatelessWidget {
  const SimpleFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getNetworkData() async {
      await Future.delayed(const Duration(seconds: 5));
      return "123";
    }

    return MaterialApp(
      home: SafeArea(
        child: FutureBuilder(
            future: getNetworkData(),
            initialData: "0000",
            builder: (BuildContext context, AsyncSnapshot<String?> data) {
              return Text(data.requireData ?? "loading");
            }),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  final int count = 0;

  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InheritedText extends InheritedWidget {
  final String text;

  const InheritedText(this.text, {super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedText oldWidget) {
    return text != oldWidget.text;
  }

  static InheritedText? of(BuildContext context) {
    var widget = context.getElementForInheritedWidgetOfExactType<InheritedText>()?.widget;
    if (widget == null) return null;
    return widget as InheritedText;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stateStr = "init";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(stateStr),
        ),
        body: InheritedText(
          stateStr,
          child: const TextPage(),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            stateStr = "change";
          });
        }),
      ),
    );
  }
}

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  var da = DataBLoc();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(InheritedText.of(context)?.text ?? "123"),
    );
  }
}

class DataBLoc {
  final _dataController = StreamController<List<String>>();

  StreamSink<List<String>> get _dataSink => _dataController.sink;

  Stream<List<String>> get _dataStream => _dataController.stream;

  late StreamSubscription _dataSubscription;

  init() {
    _dataSubscription = _dataStream.listen((event) {
      // do change
    });

    _dataSink.add(["1", "2"]);
  }

  close() {
    _dataSubscription.cancel();
    _dataController.close();
  }
}
