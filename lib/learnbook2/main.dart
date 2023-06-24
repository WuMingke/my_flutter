import 'package:flutter/material.dart';
import 'package:my_flutter/learnbook2/nav2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: MyNav2(),
      ),
      // routes: ,
      // onGenerateRoute: ,
      // onUnknownRoute: ,
    );
  }
}
