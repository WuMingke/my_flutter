import 'package:flutter/material.dart';

class MyNav2 extends StatelessWidget {
  const MyNav2({super.key});

  @override
  Widget build(BuildContext context) {
    final myPage = PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            color: Colors.green,
          ),
        );
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return ScaleTransition(
          scale: animation,
          child: RotationTransition(
            turns: animation,
            child: child,
          ),
        );
      },
    );

    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(myPage);
        },
        child: const Text("旋转打开第二个页面"),
      ),
    );
  }
}
