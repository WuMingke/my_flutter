import 'package:flutter/material.dart';

import 'snowman.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation heightAnim = Tween(begin: 50.0, end: 300.0).animate(_controller); // 添加 chain(XXX)

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: createSnowman(context, _controller),
        // body: Center(
        //   child: buildTransition(),
        // ),
      ),
    );
  }

  /// demo6
  AnimatedBuilder buildAnimatedBuilder(Animation<dynamic> heightAnim) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return InkWell(
          onTap: () {
            _controller.forward();
          },
          child: Opacity(
            opacity: _controller.value,
            child: Container(
              width: 300,
              // height: 300,
              // height: 50 + 250 * _controller.value,
              // height: Tween(begin: 50.0, end: 300.0).evaluate(_controller),
              height: heightAnim.value,
              color: Colors.redAccent,
              child: child,
            ),
          ),
        );
      },
      child: const Center(
        child: Text(
          "111",
          style: TextStyle(fontSize: 30),
        ),
      ),

      // child: Container(
      //   width: 300,
      //   height: 300,
      //   color: Colors.redAccent,
      //   child: const Center(
      //     child: Text(
      //       "111",
      //       style: TextStyle(fontSize: 30),
      //     ),
      //   ),
      // ),
    );
  }

  /// demo5
  InkWell buildTransition() {
    return InkWell(
      onTap: () {
        _controller.forward();
        // _controller.repeat();
        // _controller.stop();
        // _controller.reset();
      },
      child: Center(
        child: FadeTransition(
          // turns: _controller, // RotationTransition
          // opacity: _controller, // FadeTransition
          // scale: _controller, // ScaleTransition
          // opacity: _controller.drive(Tween(begin: 0.5, end: 1.0)),
          opacity: Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.fastOutSlowIn)).animate(_controller),
          child: Container(
            width: 300,
            height: 300,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  /// demo4
  TweenAnimationBuilder<double> buildTweenAnimationBuilder() {
    return TweenAnimationBuilder(
      // 补间：begin-end之间补充value，并且它每次的值是从当前的值往end开始计算，而不是总是从begin开始
      tween: Tween(begin: 0.0, end: 6.5),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, double value, Widget? child) {
        // value 的类型 会根据 Tween 参数的类型做改变
        // return Opacity(
        //   opacity: value,
        //   child: Container(
        //     height: 300,
        //     width: 300,
        //     color: Colors.green,
        //   ),
        // );

        return Container(
          height: 300,
          width: 300,
          color: Colors.green,
          child: Center(
            child: Transform.rotate(
              // 旋转、平移、缩放等等
              angle: value,
              child: const Text(
                "111",
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
        );
      },
    );
  }

  /// demo3
  AnimatedPadding buildAnimatedPadding() {
    return AnimatedPadding(
      // opacity: 1,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        width: 300,
        height: 300,
        color: Colors.blue,
      ),
    );
  }

  /// demo2
  Container buildAnimatedSwitcher() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.green,
      child: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        duration: const Duration(seconds: 1),
        child: Text(key: UniqueKey(), "11", style: const TextStyle(fontSize: 50)),
        // child: Image.asset("images/head.jpg", width: 100, height: 100),
      ),
    );
  }

  /// demo1
  AnimatedContainer buildAnimatedContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: 100,
      width: 200,
      // color: Colors.red,
      decoration: BoxDecoration(
        color: Colors.green,
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 25, spreadRadius: 40),
          BoxShadow(color: Colors.blue, blurRadius: 10, spreadRadius: 10),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: Text(
          "123",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
