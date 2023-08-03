import 'package:flutter/material.dart';

void main() {
  runApp(const ScrollApp());
}

class A {
  int? a;

  A() : a = 1 {
    print("=========");
  }
}

class ScrollApp extends StatefulWidget {
  const ScrollApp({super.key});

  @override
  State<ScrollApp> createState() => _ScrollAppState();
}

class _ScrollAppState extends State<ScrollApp> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
      debugShowCheckedModeBanner: false,
      home: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) => Scaffold(
          body: Scrollbar(
            // thumbVisibility: true,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 30,
                  child: Center(
                    child: Text("$index 个"),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                  child: Div(),
                );
              },
              itemCount: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class Div extends StatelessWidget {
  const Div({super.key});

  @override
  Widget build(BuildContext context) {
    print("==Div  build==");
    return const SizedBox(
      height: 10,
      child: FlutterLogo(),
    );
  }
}
