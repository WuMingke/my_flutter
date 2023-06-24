import 'package:flutter/material.dart';

class MyIgnoreWidget extends StatelessWidget {
  const MyIgnoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            print("响应");
          },
          child: const Text("ElevatedButton 按钮"),
        ),
        IgnorePointer(
          ignoring: false,
          child: ElevatedButton(
            onPressed: () {
              print("无法响应");
            },
            child: const Text("IgnorePointer 按钮"),
          ),
        ),
        Draggable(
          feedback: Container(
            width: 50,
            height: 50,
            color: Colors.grey[500],
          ),
          childWhenDragging: const FlutterLogo(),
          maxSimultaneousDrags: 2,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
