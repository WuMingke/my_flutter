import 'package:flutter/material.dart';

class Animation1 extends StatefulWidget {
  const Animation1({super.key});

  @override
  State<Animation1> createState() => _Animation1State();
}

/// AnimatedCrossFade AnimatedIcon AnimatedList AnimatedSize ExpandIcon

class _Animation1State extends State<Animation1> {
  @override
  Widget build(BuildContext context) {
    // TODO: 2023/6/5 mingKE 有问题
    return const AnimatedSwitcher(
      duration: Duration(seconds: 1),
    );
  }
}
