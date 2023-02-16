import 'package:flutter/material.dart';

void main() {
  // runApp(const ColoredBox(color: Colors.blue));

  BoxConstraints? mConstraints;

  runApp(MaterialApp(
    home: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        mConstraints = constraints;
        return Align(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              print("--- ${identical(mConstraints, constraints)}");
              print("--- ${mConstraints == constraints}");
              return const SizedBox(
                height: 300,
                width: 300,
                child: ColoredBox(color: Colors.green),
              );
            },
          ),
        );
      },
    ),
  ));
}
