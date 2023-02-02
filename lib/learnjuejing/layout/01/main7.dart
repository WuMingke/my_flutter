import 'package:flutter/material.dart';

void main() {
  runApp(
    ColoredBox(
      color: Colors.white,
      child: CustomSingleChildLayout(
        delegate: MyLayout(),
        child: const ColoredBox(color: Colors.blue),
      ),
    ),
  );
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
