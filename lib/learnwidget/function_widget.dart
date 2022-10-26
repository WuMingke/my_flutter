import 'package:flutter/material.dart';

class _TestWidget extends StatefulWidget {
  const _TestWidget({Key? key}) : super(key: key);

  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context)!.data.toString());
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data;

  const ShareDataWidget(this.data, {super.key, required super.child});

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class TestWillPop extends StatefulWidget {
  const TestWillPop({Key? key}) : super(key: key);

  @override
  State<TestWillPop> createState() => _TestWillPopState();
}

class _TestWillPopState extends State<TestWillPop> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: const Text("exit"),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 10)) {
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        });
  }
}
