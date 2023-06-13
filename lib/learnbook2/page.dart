import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: PageView(
        // pageSnapping: false,
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          Dismissible(
            key: UniqueKey(),
            child: Container(
              color: Colors.greenAccent,
              child: const Text('first page'),
            ),
          ),
          Container(
            color: Colors.blue,
            child: const Text('second page'),
          ),
          Container(
            color: Colors.red,
            child: const Text('third page'),
          ),
          Container(
            color: Colors.amber,
            child: const Text('fourth page'),
          ),
        ],
      ),
    );
  }
}
