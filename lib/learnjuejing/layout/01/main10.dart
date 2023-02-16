import 'package:flutter/material.dart';

void main() {
  runApp(
    LoopLayout(),
  );
}

class LoopLayout extends StatelessWidget {
  const LoopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        const SizedBox(
          width: 50,
          height: 50,
          child: ColoredBox(
            color: Colors.blue,
          ),
        ),
        const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
              child: ColoredBox(
                color: Colors.white,
              ),
            )),
        const Expanded(
            flex: 2,
            child: SizedBox(
              height: 10,
              child: ColoredBox(
                color: Colors.green,
              ),
            )),
        Container(
          height: 10,
          width: 10,
          color: Colors.redAccent,
        ),
      ],
    );
  }
}
