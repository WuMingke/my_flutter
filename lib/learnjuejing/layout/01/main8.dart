import 'package:flutter/material.dart';

void main() {
  runApp(
    ColoredBox(
      color: Colors.white,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        print("----------constraints:$constraints--------------");
        return CustomSingleChildLayout(
          delegate: MyLayout(),
          child: const ColoredBox(color: Colors.blue),
        );
      }),
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
