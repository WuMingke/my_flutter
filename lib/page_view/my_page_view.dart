import 'package:flutter/material.dart';

class MyPageViewTest extends StatefulWidget {
  const MyPageViewTest({super.key});

  @override
  State<MyPageViewTest> createState() => _MyPageViewTestState();
}

class _MyPageViewTestState extends State<MyPageViewTest> {
  final _controller = PageController(
    initialPage: 1,
    viewportFraction: 0.3, // 每个item的大小
  );
  final children = <Widget>[];
  final colors = [
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.grey,
    Colors.indigoAccent,
  ];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 6; ++i) {
      children.add(
        Page(
          text: '$i',
          color: colors[i],
        ),
      );
    }

    _controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String text;
  final Color color;

  const Page({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: Text(text, textScaleFactor: 5),
    );
  }
}
