import 'package:flutter/material.dart';

class TestLayout extends StatelessWidget {
  const TestLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget redBox = const DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    Widget wrapperSizeBox = SizedBox(
      width: 100,
      height: 100,
      child: redBox,
    );

    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 90.0, maxHeight: 20.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 20.0, maxHeight: 10.0),
          child: wrapperSizeBox,
        ));
  }
}
