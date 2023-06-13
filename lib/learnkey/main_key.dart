import 'dart:async';

import 'package:flutter/material.dart';

void main() async {
  print("future     1");
  Future.value(getNum());
  Future.sync(() => print('future     1.2'));
  print('future     2');

  final data = await fetchData();
  print(data);

  runApp(const MyApp());
}

double getNum() {
  print('future     1.1');
  return 1.1;
}

Future<String> fetchData() async {
  final completer = Completer<String>();

  Timer(const Duration(seconds: 2), () {
    completer.complete('complete..');
  });

  return completer.future;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        throw Exception("something error");
      },
    )
        .then(
      (value) => print('result success'),
    )
        .catchError(
      (error) {
        print("result error ${error.toString()}");
      },
    ).whenComplete(
      () => print("result complete"),
    );

    /// then-catchError-whenComplete  => try-catch-finally
    ///
    // _controller = co
    _controller.forward().then((value) => () {
          //
        });
    // _controller.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //    //
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
