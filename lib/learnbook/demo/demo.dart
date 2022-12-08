import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(
        color: Colors.transparent,
      );
    };
    FlutterError.onError = (FlutterErrorDetails details) async {
      FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    };
    runApp(const FlutterReduxApp());
  }, onError: (Object obj, StackTrace trace) {
    print(obj);
    print(trace);
  });
}

class FlutterReduxApp extends StatelessWidget {
  const FlutterReduxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("123"),
        ),
        body: const Text("123"),
      ),
    );
  }
}

class A {
  int _id = 0;

  int getId() => this._id;
}

class B {
  var a = A();

  void b() {
    a.getId();
    a._id;
  }
}
