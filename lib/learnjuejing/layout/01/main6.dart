import 'package:flutter/material.dart';

void main() {
  runApp(CustomSingleChildLayout(
    delegate: MyLayout(),
    child: const ColoredBox(color: Colors.blueAccent),
  ));
}

class MyLayout extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return false;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.tight(const Size(100, 100));
  }
}
