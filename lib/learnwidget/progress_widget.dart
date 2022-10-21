import 'package:flutter/material.dart';

class TestProgress extends StatelessWidget {
  const TestProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          value: 0.6,
        ),
        CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          value: .3,
        ),
        SizedBox(
          height: 1,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            value: .5,
          ),
        ),
        SizedBox(
          height: 100,
          width: 300,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            value: .7,
            strokeWidth: 10,
          ),
        ),
      ],
    );
  }
}

class ProgressRoute extends StatefulWidget {
  const ProgressRoute({Key? key}) : super(key: key);

  @override
  State<ProgressRoute> createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animationController?.forward();
    _animationController?.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController!), // 从灰色变成蓝色
              value: _animationController!.value,
            ),
          ),
        ],
      ),
    );
  }
}
