import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Flex(
        direction: Axis.vertical,
        children: [
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints cons) {
              print("$cons");
              return Container(
                color: Colors.blue,
                width: 100000,
                height: 100,
                child: const SizedBox(
                  width: 80,
                  height: 80,
                  child: ColoredBox(
                    color: Colors.redAccent,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
