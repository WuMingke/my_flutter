import 'package:flutter/material.dart';

class MyDragg extends StatelessWidget {
  const MyDragg({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, controller) {
        return Container(
          color: Colors.green,
          child: ListView.builder(
            controller: controller,
            itemBuilder: (_, index) {
              return Text("item $index");
            },
          ),
        );
      },
    );
  }
}
